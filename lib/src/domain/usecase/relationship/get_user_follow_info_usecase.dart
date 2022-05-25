import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class GetUserFollowInfoUsecase extends UseCase<AmityUserFollowInfo, String> {
  final FollowRepo followRepo;
  GetUserFollowInfoUsecase({required this.followRepo});
  @override
  Future<AmityUserFollowInfo> get(String params) {
    return followRepo.getFollowInfo(params);
  }

  @override
  Stream<AmityUserFollowInfo> listen(String params) {
    // TODO: implement listen
    throw UnimplementedError();
  }
}
