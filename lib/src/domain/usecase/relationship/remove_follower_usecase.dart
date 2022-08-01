import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// Remove Follow Usecase
class RemoveFollowerUsecase extends UseCase<AmityFollowStatus, String> {
  /// Follow Repo
  final FollowRepo followRepo;

  /// Init Remove follow usecase
  RemoveFollowerUsecase({required this.followRepo});
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
