import 'dart:developer' as developer;
import 'dart:math' as math;

import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/core_client.dart';
import 'package:amity_sdk/src/core/enum/amity_error.dart';
import 'package:amity_sdk/src/data/converter/user/users_response_extension.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/repo/authentication_repo.dart';

class AuthenticationRepoImpl extends AuthenticationRepo {
  final AuthenticationApiInterface authenticationApiInterface;
  final AccountDbAdapter accountDbAdapter;
  final UserDbAdapter userDbAdapter;
  final FileDbAdapter fileDbAdapter;
  final AmityCoreClientOption coreClientOption;
  static final double ABOUT_TO_EXPIRE_TRESHOLD = 0.8;

  AuthenticationRepoImpl(
      {required this.authenticationApiInterface,
      required this.accountDbAdapter,
      required this.userDbAdapter,
      required this.fileDbAdapter,
      required this.coreClientOption});
  @override
  Future<AmityUser> login(AuthenticationRequest params, {required bool isLegacyVersion}) async {
    // - login user from remote data source
    // - save the user in DTO
    // - Return the public Amity user to domain layer

    ///FIXME: saving auth request to use it in Dio [AuthInterceptor]
    if (serviceLocator.isRegistered<AuthenticationRequest>()) {
      serviceLocator.unregister<AuthenticationRequest>();
    }
    serviceLocator.registerSingleton<AuthenticationRequest>(params);

    //1. Get the data from data remote data source
    final data = await authenticationApiInterface.login(params, isLegacyVersion: isLegacyVersion);

    //2. Change remote response to dto
    var accountHiveEntity = data.convertToAccountHiveEntity();
    final userHiveEntity = data.users[0].convertToUserHiveEntity();
    final fileHiveEntities = data.files.map((e) => e.convertToFileHiveEntity());

    accountHiveEntity.deviceId = params.deviceId;

    //3. Save the dto in the db
    await accountDbAdapter.saveAccountEntity(accountHiveEntity);
    await userDbAdapter.saveUserEntity(userHiveEntity);
    for (var e in fileHiveEntities) {
      await fileDbAdapter.saveFileEntity(e);
    }

    //4. Change dto to public amity user
    final amityUser = userHiveEntity.convertToAmityUser();

    //Keep the current session detail (service locator)
    if (serviceLocator.isRegistered<AccountHiveEntity>()) {
      serviceLocator.unregister<AccountHiveEntity>();
    }
    serviceLocator.registerSingleton<AccountHiveEntity>(accountHiveEntity);

    //Keep the current user in session (service locator)
    if (serviceLocator.isRegistered<AmityUser>()) {
      serviceLocator.unregister<AmityUser>();
    }
    serviceLocator.registerSingleton<AmityUser>(amityUser);

    return Future.value(amityUser);
  }

  @override
  Future<AmityUserToken> getUserToken(AuthenticationRequest params, {required bool isLegacyVersion}) async {
    final data = await authenticationApiInterface.login(params, isLegacyVersion: isLegacyVersion);
    return Future.value(AmityUserToken(accessToken: data.accessToken));
  }

  @override
  Future<void> renewToken({
  required AccountHiveEntity account,
  String? displayName,
  String? authToken,
  required bool isLegacyVersion,
}) async {
  try {
    try {
      final response = await _retryWithExponentialBackoff(
        maxAttempts: 3,
        initialDelay: const Duration(seconds: 1),
        maxDelay: const Duration(seconds: 10),
        scaleFactor: 1.5,
        operation: () => authenticationApiInterface.login(AuthenticationRequest(
          userId: account.userId!,
          displayName: displayName,
          deviceId: account.deviceId,
          authToken: authToken,
        ), isLegacyVersion: isLegacyVersion ),
        shouldRetry: (error) => 
          error != AmityException || (error == AmityException && (error as AmityException).toAmityError() != AmityError.USER_IS_GLOBAL_BANNED),
      );

      // Update account tokens
      account.refreshToken = response.refreshToken;
      account.accessToken = response.accessToken;

      if (isLegacyVersion) {
        // For legacy version, there's no expiration yet
        account.issuedAt = DateTime.now();
        account.expiresAt = DateTime.now().add(const Duration(days: 365));
      } else {
        account.issuedAt = response.issuedAt;
        account.expiresAt = response.expiresAt;
      }

      final expiresAt = account.expiresAt;
      final issuedAt = account.issuedAt;
      if (expiresAt != null && issuedAt != null) {
        final tokenDuration = (expiresAt.millisecondsSinceEpoch - 
                            issuedAt.millisecondsSinceEpoch - 
                            CoreClient.millisTimeDiff) * 
                            ABOUT_TO_EXPIRE_TRESHOLD;

        account.aboutToExpireAt = issuedAt.add(
          Duration(milliseconds: tokenDuration.toInt())
        );

        developer.log(
          "Token renewed: account updated:\n" +
          "expiresAt = ${account.expiresAt}\n" +
          'aboutToExpireAt = ${account.aboutToExpireAt}\n' +
          'issuedAt = ${account.issuedAt}\n' +
          'duration = ${tokenDuration / 1000} sec'
        );
      }

      final users = UsersResponse(
        users: response.users ?? [],
        files: response.files ?? [],
      );

      accountDbAdapter.saveAccountEntity(account);
      await users.saveToDb(userDbAdapter, fileDbAdapter);
    } catch (error) {
      await CoreClient.logout();
      rethrow;
    }
  } catch (error) {
    throw error;
  }
}

Future<T> _retryWithExponentialBackoff<T>({
  required int maxAttempts,
  required Duration initialDelay,
  required Duration maxDelay,
  required double scaleFactor,
  required Future<T> Function() operation,
  required bool Function(dynamic error) shouldRetry,
}) async {
  int attempts = 0;
  Duration delay = initialDelay;

  while (true) {
    try {
      attempts++;
      return await operation();
    } catch (error) {
      if (attempts >= maxAttempts || !shouldRetry(error)) {
        rethrow;
      }

      await Future.delayed(delay);
      delay = Duration(
        milliseconds: math.min(
          maxDelay.inMilliseconds,
          (delay.inMilliseconds * scaleFactor).toInt(),
        ),
      );
    }
  }
}
}
