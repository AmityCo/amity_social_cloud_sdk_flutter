import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// Accept Follow Usecase
class AcceptFollowUsecase extends UseCase<AmityFollowStatus, String> {
  /// Follow Repo
  final FollowRepo followRepo;

  /// Init AcceptFollowUsecase with Follow Repo
  AcceptFollowUsecase({required this.followRepo});
  @override
  Future<AmityFollowStatus> get(String params) {
    return followRepo.accpet(params);
  }
}
