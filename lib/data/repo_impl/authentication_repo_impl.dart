import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/data/data.dart';
import 'package:amity_sdk/domain/model/amity_user.dart';
import 'package:amity_sdk/domain/repo/authentication_repo.dart';

class AuthenticationRepoImpl extends AuthenticationRepo {
  final AuthenticationApiInterface authenticationApiInterface;
  final AccountDbAdapter accountDbAdapter;
  final UserDbAdapter userDbAdapter;
  AuthenticationRepoImpl(
      {required this.authenticationApiInterface,
      required this.accountDbAdapter,
      required this.userDbAdapter});
  @override
  Future<AmityUser> login(AuthenticationRequest params) async {
    // - login user from remote data source
    // - save the user in DTO
    // - Return the public Amity user to domain layer

    //1. Get the data from data remote data source
    final data = await authenticationApiInterface.login(params);
    // final userHiveEntity = data.users[0].convertToUserHiveEntity();

    //2. Change remote response to dto
    final accountHiveEntity = data.convertToAccountHiveEntity();
    final userHiveEntity = data.users[0].convertToUserHiveEntity();

    //3. Save the dto in the db
    accountDbAdapter.saveAccountEntity(accountHiveEntity);
    userDbAdapter.saveUserEntity(userHiveEntity);

    //4. Change dto to public amity user
    final amityUser = accountHiveEntity.convertToAmityUser();

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
}
