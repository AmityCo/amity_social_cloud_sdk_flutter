import 'package:amity_sdk/src/data/data_source/local/hive_entity/reaction_hive_entity_8.dart';

abstract class ReactionDbAdapter {
  Future saveReactionEntity(ReactionHiveEntity data);
  Future deleteReactionEntity(ReactionHiveEntity data);
  ReactionHiveEntity getReactionEntity(String reactionId);
}
