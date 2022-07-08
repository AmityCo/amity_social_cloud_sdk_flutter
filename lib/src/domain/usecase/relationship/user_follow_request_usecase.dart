import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// User Follow Request Usecase
class UserFollowRequestUsecase extends UseCase<AmityFollowStatus, String> {
  /// Follow Repo
  final FollowRepo followRepo;

  /// Inti UserFollow Request Usecase
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
