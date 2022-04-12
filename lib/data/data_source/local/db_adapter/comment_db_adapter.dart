import 'package:amity_sdk/data/data_source/local/hive_entity/comment_hive_entity_6.dart';

abstract class CommentDbAdapter {
  Future saveCommentEntity(CommentHiveEntity entity);
  CommentHiveEntity getCommentEntity(String id);
}
