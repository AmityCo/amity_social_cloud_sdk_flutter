import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/domain/domain.dart';

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
