import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/domain/domain.dart';

class AmityFollowRelationshipComposerUsecase
    extends UseCase<AmityFollowRelationship, AmityFollowRelationship> {
  final UserRepo userRepo;
  AmityFollowRelationshipComposerUsecase({required this.userRepo});

  @override
  Future<AmityFollowRelationship> get(AmityFollowRelationship params) async {
    params.targetUser = await userRepo.getUserByIdFromDb(params.targetUserId!);
    params.sourceUser = await userRepo.getUserByIdFromDb(params.sourceUserId!);
    return params;
  }

  @override
  Stream<AmityFollowRelationship> listen(AmityFollowRelationship params) {
    throw UnimplementedError();
  }
}
