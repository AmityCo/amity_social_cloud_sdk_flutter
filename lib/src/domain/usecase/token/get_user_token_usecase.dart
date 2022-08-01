import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/domain/model/amity_user_token.dart';

class GetUserTokenUsecase
    extends UseCase<AmityUserToken, AuthenticationRequest> {
  final AuthenticationRepo authenticationRepo;

  GetUserTokenUsecase({required this.authenticationRepo});

  @override
  Future<AmityUserToken> get(AuthenticationRequest params) async {
    final amityUserToken = await authenticationRepo.getUserToken(params);
    return amityUserToken;
  }

  @override
  Stream<AmityUserToken> listen(AuthenticationRequest params) {
    throw UnimplementedError();
  }
}
