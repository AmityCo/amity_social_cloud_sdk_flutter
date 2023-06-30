import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class GetUserFollowInfoUsecase extends UseCase<AmityUserFollowInfo, String> {
  final FollowRepo followRepo;
  GetUserFollowInfoUsecase({required this.followRepo});
  @override
  Future<AmityUserFollowInfo> get(String params) {
    if (params.isNotEmpty) {
          return followRepo.getFollowInfo(params);
    } else {
       throw Exception('userId can not be empty');
    }
  }
}
