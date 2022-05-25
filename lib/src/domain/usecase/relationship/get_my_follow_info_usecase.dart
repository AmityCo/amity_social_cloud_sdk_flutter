import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class GetMyFollowInfoUsecase extends UseCaseWithoutParam<AmityUserFollowInfo> {
  final FollowRepo followRepo;
  GetMyFollowInfoUsecase({required this.followRepo});
  @override
  Future<AmityUserFollowInfo> get() {
    return followRepo.getMyFollowInfo();
  }

  @override
  Stream<AmityUserFollowInfo> listen() {
    // TODO: implement listen
    throw UnimplementedError();
  }
}
