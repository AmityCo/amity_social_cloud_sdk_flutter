import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/data/data.dart';
import 'package:amity_sdk/domain/model/amity_user.dart';
import 'package:amity_sdk/domain/repo/authentication_repo.dart';

class AuthenticationRepoImpl extends AuthenticationRepo {
  final AuthenticationApiInterface authenticationApiInterface;
  final AccountDbAdapter accountDbAdapter;
  AuthenticationRepoImpl(
      {required this.authenticationApiInterface,
      required this.accountDbAdapter});
  @override
  Future<AmityUser> login(AuthenticationRequest params) async {
    // - login user from remote data source
    // - save the user in DTO
    // - Return the public Amity user to domain layer
    final data = await authenticationApiInterface.login(params);
    final userHiveEntity = data.users[0].convertToUserHiveEntity();
    // await userHiveEntity.save();
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
}
