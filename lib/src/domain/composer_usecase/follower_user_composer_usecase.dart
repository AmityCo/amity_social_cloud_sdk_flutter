import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class FollowerUserComposerUsecase
    extends UseCase<AmityFollowRelationship, AmityFollowRelationship> {
  /// User Repo
  final FollowRepo followRepo;

  /// User Repo
  final UserRepo userRepo;

  /// User Composer Usecase
  final UserComposerUsecase userComposerUsecase;

  /// Init [MessageComposerUsecase]
  FollowerUserComposerUsecase({
    required this.followRepo,
    required this.userRepo,
    required this.userComposerUsecase,
  });

  @override
  Future<AmityFollowRelationship> get(AmityFollowRelationship params) async {
    if (params.targetUserId != null) {
      params.targetUser =
          await userRepo.getUserByIdFromDb(params.targetUserId!);
      params.targetUser = await userComposerUsecase.get(params.targetUser!);
    }

    if (params.sourceUserId != null) {
      params.sourceUser =
          await userRepo.getUserByIdFromDb(params.sourceUserId!);
      params.sourceUser = await userComposerUsecase.get(params.sourceUser!);
    }

    return params;
  }
}
