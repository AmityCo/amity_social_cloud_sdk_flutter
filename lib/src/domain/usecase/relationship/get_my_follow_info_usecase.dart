import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class GetMyFollowInfoUsecase extends UseCaseWithoutParam<AmityMyFollowInfo> {
  final FollowRepo followRepo;
  GetMyFollowInfoUsecase({required this.followRepo});
  @override
  Future<AmityMyFollowInfo> get() {
    return followRepo.getMyFollowInfo();
  }
}
