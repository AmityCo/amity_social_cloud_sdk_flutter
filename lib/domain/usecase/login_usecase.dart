import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/domain/domain.dart';

class LoginUsecase extends UseCase<AmityUser, AuthenticationRequest> {
  final AuthenticationRepo authenticationRepo;
  final UserComposerUsecase userComposerUsecase;
  LoginUsecase(
      {required this.authenticationRepo, required this.userComposerUsecase});

  @override
  Future<AmityUser> get(AuthenticationRequest params) async {
    //1. Get the public model (AmityUser) from data layer
    //2. Use the composer usecase to compose the public model (fill the detail)

    final amityUser = await authenticationRepo.login(params);
    final amityComposedUser = await userComposerUsecase.get(amityUser);
    return amityComposedUser;
  }

  @override
  Stream<AmityUser> listen(AuthenticationRequest params) {
    throw UnimplementedError();
  }
}
