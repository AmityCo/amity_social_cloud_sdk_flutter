import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/domain/domain.dart';

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
