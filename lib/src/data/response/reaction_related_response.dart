import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/data/data_source/data_source.dart';
import 'package:amity_sdk/src/data/data_source/local/db_adapter/reaction_related_db_adapter.dart';
import 'package:amity_sdk/src/data/response/core_response/base_reponse.dart';
import 'package:amity_sdk/src/data/response/response.dart';

mixin ReactionRelatedResponse {
  Future saveReactionFromEvent(DbAdapterRepo dbRepo, List<UserResponse> users,
      Reactor? reactor, AmityReactionReferenceType refType) async {
    final responses = getResponses();
    ReactionRelatedDBAdapter? dbAdapter;
    if (refType == AmityReactionReferenceType.POST) {
      dbAdapter = dbRepo.postDbAdapter;
    } else if (refType == AmityReactionReferenceType.COMMENT) {
      dbAdapter = dbRepo.commentDbAdapter;
    } else if (refType == AmityReactionReferenceType.MESSAGE) {
      dbAdapter = dbRepo.messageDbAdapter;
    } else if (refType == AmityReactionReferenceType.STORY) {
      dbAdapter = dbRepo.storyDbAdapter;
    }
    final id = responses.isNotEmpty ? responses.first.getId() : '';
    final UserResponse? user = users.cast<UserResponse?>().firstWhere(
        (user) => user?.userId != null && user?.userId == reactor?.userId,
        orElse: () => null);
    if (reactor != null && id.isNotEmpty && dbAdapter != null) {
      final reactionEntity = ReactionHiveEntity();
      reactionEntity
        ..reactionId = reactor.reactionId
        ..referenceType = refType.value
        ..referenceId = id
        ..reactionName = reactor.reactionName
        ..userId = reactor.userId
        ..userDisplayName = user?.displayName
        ..createdAt = reactor.createdAt;
      if (reactor.eventName == "add") {
        final entity = await dbAdapter.getEntity(id);
        if (entity != null) {
          if (reactor.userId == AmityCoreClient.getUserId()) {
            entity.myReactions ??= [];
            entity.myReactions!.add(reactor.reactionName);
          }
          await dbAdapter.saveEntity(entity);
        }
        if (reactor.updatedAt != null) {
          reactionEntity.setUpdatedAt(reactor.updatedAt!);
        }
        dbRepo.reactionDbAdapter.saveReactionEntity(reactionEntity);
      } else if (reactor.eventName == "remove") {
        final entity = await dbAdapter.getEntity(id);
        if (entity != null) {
          if (reactor.userId == AmityCoreClient.getUserId()) {
            entity.myReactions ??= [];
            entity.myReactions!.remove(reactor.reactionName);
          }
          await dbAdapter.saveEntity(entity);
        }
        dbRepo.reactionDbAdapter.deleteReactionEntity(reactionEntity);
      }
    }
  }

  List<BaseResponse> getResponses();
}
