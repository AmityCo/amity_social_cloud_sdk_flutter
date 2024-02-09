import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/model/amity_user.dart';
import 'package:amity_sdk/src/domain/model/amity_user_token.dart';
import 'package:amity_sdk/src/domain/repo/authentication_repo.dart';

class AuthenticationRepoImpl extends AuthenticationRepo {
  final AuthenticationApiInterface authenticationApiInterface;
  final AccountDbAdapter accountDbAdapter;
  final UserDbAdapter userDbAdapter;
  final FileDbAdapter fileDbAdapter;
  AuthenticationRepoImpl(
      {required this.authenticationApiInterface,
      required this.accountDbAdapter,
      required this.userDbAdapter,
      required this.fileDbAdapter});
  @override
  Future<AmityUser> login(AuthenticationRequest params) async {
    // - login user from remote data source
    // - save the user in DTO
    // - Return the public Amity user to domain layer

    ///FIXME: saving auth request to use it in Dio [AuthInterceptor]
    if (serviceLocator.isRegistered<AuthenticationRequest>()) {
      serviceLocator.unregister<AuthenticationRequest>();
    }
    serviceLocator.registerSingleton<AuthenticationRequest>(params);

    //1. Get the data from data remote data source
    final data = await authenticationApiInterface.login(params);

    //2. Change remote response to dto
    var accountHiveEntity = data.convertToAccountHiveEntity();
    final userHiveEntity = data.users[0].convertToUserHiveEntity();
    final fileHiveEntities = data.files.map((e) => e.convertToFileHiveEntity());

    accountHiveEntity.deviceId = params.deviceId;

    //3. Save the dto in the db
    accountDbAdapter.saveAccountEntity(accountHiveEntity);
    userDbAdapter.saveUserEntity(userHiveEntity);
    for (var e in fileHiveEntities) {
      await fileDbAdapter.saveFileEntity(e);
    }

    //4. Change dto to public amity user
    final amityUser = userHiveEntity.convertToAmityUser();

    //Keep the current session detail (service locator)
    if (serviceLocator.isRegistered<SessionResponse>()) {
      serviceLocator.unregister<SessionResponse>();
    }
    serviceLocator.registerSingleton<SessionResponse>(data);

    //Keep the current user in session (service locator)
    if (serviceLocator.isRegistered<AmityUser>()) {
      serviceLocator.unregister<AmityUser>();
    }
    serviceLocator.registerSingleton<AmityUser>(amityUser);



    return Future.value(amityUser);
  }

  @override
  Future<AmityUserToken> getUserToken(AuthenticationRequest params) async {
    final data = await authenticationApiInterface.login(params);
    return Future.value(AmityUserToken(accessToken: data.accessToken));
  }
}
