import 'package:amity_sdk/src/data/data_source/data_source.dart';
import 'package:amity_sdk/src/data/response/response.dart';

extension ReactionResponseExtension on Reactor {
  ReactionHiveEntity convertToReactionHiveEntity(
      String referenceId, String referenceType) {
    return ReactionHiveEntity()
      ..reactionId = reactionId
      ..reactionName = reactionName
      ..referenceId = referenceId
      ..referenceType = referenceType
      ..userId = userId
      ..createdAt = createdAt;
  }
}
