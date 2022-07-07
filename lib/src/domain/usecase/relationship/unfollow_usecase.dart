import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// UnFollow User
class UnfollowUsecase extends UseCase<AmityFollowStatus, String> {
  /// Follow Repo
  final FollowRepo followRepo;

  /// Init UnFollow Usecase
  UnfollowUsecase({required this.followRepo});
  @override
  Future<AmityFollowStatus> get(String params) {
    return followRepo.unfollow(params);
  }

  @override
  Stream<AmityFollowStatus> listen(String params) {
    // TODO: implement listen
    throw UnimplementedError();
  }
}
