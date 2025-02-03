import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/core_client.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class GetUserTokenUsecase
    extends UseCase<AmityUserToken, AuthenticationRequest> {
  final AuthenticationRepo authenticationRepo;

  GetUserTokenUsecase({required this.authenticationRepo});

  @override
  Future<AmityUserToken> get(AuthenticationRequest params) async {
    final amityUserToken = await authenticationRepo.getUserToken(params, isLegacyVersion: CoreClient.isLegacyLogin());
    return amityUserToken;
  }
}
