import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/core_client.dart';
import 'package:amity_sdk/src/data/data_source/data_source.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class LoginUsecase extends UseCase<AmityUser, AuthenticationRequest> {
  final AccountDbAdapter accountDbAdapter;
  final AuthenticationRepo authenticationRepo;
  final UserComposerUsecase userComposerUsecase;
  LoginUsecase(
      {required this.authenticationRepo,
      required this.userComposerUsecase,
      required this.accountDbAdapter});

  @override
  Future<AmityUser> get(AuthenticationRequest params) async {
    //1. Get the public model (AmityUser) from data layer
    //2. Use the composer usecase to compose the public model (fill the detail)
    final isLegacyVersion = CoreClient.isLegacyLogin();
    final amityUser = await authenticationRepo.login(params, isLegacyVersion: isLegacyVersion);
    final amityComposedUser = await userComposerUsecase.get(amityUser);
    return amityComposedUser;
  }

}
