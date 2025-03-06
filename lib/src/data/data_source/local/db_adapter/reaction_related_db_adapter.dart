import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/data/data_source/local/interface/reaction_related_entity.dart';

mixin ReactionRelatedDBAdapter<Entity extends ReactionRelatedEntity> {
  Future<Entity> optimisticAddReaction(
      Entity entity, String reactionName, String userId) async {
    final localCopy = entity.copyEntity();
    if (userId == AmityCoreClient.getUserId()) {
      localCopy.myReactions ??= [];
      localCopy.myReactions!.add(reactionName);
    }
    localCopy.reactionsCount = (localCopy.reactionsCount ?? 0) + 1;
    localCopy.reactions ??= {};
    localCopy.reactions![reactionName] =
        (localCopy.reactions![reactionName] ?? 0) + 1;
    await saveEntity(localCopy);
    return localCopy;
  }

  Future<Entity> optimisticRemoveReaction(
      Entity entity, String reactionName, String userId) async {
    final localCopy = entity.copyEntity();
    if (userId == AmityCoreClient.getUserId()) {
      localCopy.myReactions ??= [];
      localCopy.myReactions!.remove(reactionName);
    }
    localCopy.reactionsCount = (localCopy.reactionsCount ?? 0) - 1;
    localCopy.reactions ??= {};
    localCopy.reactions![reactionName] =
        (localCopy.reactions![reactionName] ?? 0) - 1;

    await saveEntity(localCopy);

    return localCopy;
  }

  Future saveEntity(Entity entity);

  Future<Entity?> getEntity(String id);
}
