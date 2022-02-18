import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/domain/domain.dart';

class UserFollowRequestUsecase extends UseCase<AmityFollowStatus, String> {
  final FollowRepo followRepo;
  UserFollowRequestUsecase({required this.followRepo});
  @override
  Future<AmityFollowStatus> get(String params) {
    return followRepo.follow(params);
  }

  @override
  Stream<AmityFollowStatus> listen(String params) {
    // TODO: implement listen
    throw UnimplementedError();
  }
}
