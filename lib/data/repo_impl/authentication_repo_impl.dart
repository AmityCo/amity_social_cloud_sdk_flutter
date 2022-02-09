import 'package:amity_sdk/data/data_source/remote/api_interface/authentication_api_interface.dart';
import 'package:amity_sdk/data/response/session_response.dart';
import 'package:amity_sdk/domain/model/amity_user.dart';
import 'package:amity_sdk/core/model/api_request/authentication_request.dart';
import 'package:amity_sdk/domain/repo/authentication_repo.dart';

class AuthenticationRepoImpl extends AuthenticationRepo {
  final AuthenticationApiInterface authenticationApiInterface;

  AuthenticationRepoImpl({required this.authenticationApiInterface});
  @override
  Future<AmityUser> login(AuthenticationRequest params) async {
    final SessionResponse data = await authenticationApiInterface.login(params);
    return Future.value(AmityUser());
  }
}
