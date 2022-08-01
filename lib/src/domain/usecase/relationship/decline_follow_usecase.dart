import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// Decline Follow Usecase
class DeclineFollowUsecase extends UseCase<AmityFollowStatus, String> {
  /// Follow Repo
  final FollowRepo followRepo;

  /// Init Decline Follow Usecase
  DeclineFollowUsecase({required this.followRepo});
  @override
  Future<AmityFollowStatus> get(String params) {
    return followRepo.decline(params);
  }

  @override
  Stream<AmityFollowStatus> listen(String params) {
    // TODO: implement listen
    throw UnimplementedError();
  }
}
