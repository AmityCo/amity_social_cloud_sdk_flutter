import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/domain/domain.dart';

class AmityFollowRelationshipComposerUsecase
    extends UseCase<AmityFollowRelationship, AmityFollowRelationship> {
  final UserRepo userRepo;
  final UserComposerUsecase userComposerUsecase;
  AmityFollowRelationshipComposerUsecase(
      {required this.userRepo, required this.userComposerUsecase});

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

  @override
  Stream<AmityFollowRelationship> listen(AmityFollowRelationship params) {
    throw UnimplementedError();
  }
}
