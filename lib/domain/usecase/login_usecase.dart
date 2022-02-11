import 'package:amity_sdk/core/model/api_request/authentication_request.dart';
import 'package:amity_sdk/core/usercase/usecase.dart';
import 'package:amity_sdk/domain/repo/authentication_repo.dart';
import 'package:amity_sdk/public/public.dart';

class LoginUsecase extends UseCase<AmityUser, AuthenticationRequest> {
  final AuthenticationRepo authenticationRepo;

  LoginUsecase({required this.authenticationRepo});

  @override
  Future<AmityUser> get(AuthenticationRequest params) {
    return authenticationRepo.login(params);
  }

  @override
  Stream<AmityUser> listen(AuthenticationRequest params) {
    throw UnimplementedError();
  }
}
