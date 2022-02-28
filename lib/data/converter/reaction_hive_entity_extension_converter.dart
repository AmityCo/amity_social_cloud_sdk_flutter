import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/data/data_source/data_source.dart';
import 'package:amity_sdk/domain/domain.dart';
import 'package:amity_sdk/domain/model/amity_reaction.dart';

extension ReactionHiveEntityExtension on ReactionHiveEntity {
  AmityReaction convertToAmityReaction() {
    return AmityReaction()
      ..reactionId = reactionId
      ..referenceType = referenceType
      ..reactionName = reactionName
      ..userId = userId
      ..userDisplayName = userDisplayName
      ..createdAt = createdAt;
  }
}
