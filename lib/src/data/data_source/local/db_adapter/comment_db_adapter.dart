import 'package:amity_sdk/src/data/data_source/local/hive_entity/comment_hive_entity_6.dart';

abstract class CommentDbAdapter {
  Future saveCommentEntity(CommentHiveEntity entity);
  CommentHiveEntity? getCommentEntity(String id);
  Stream<CommentHiveEntity> listenCommentEntity(String commentId);

  Future updateChildComment(String parentCommentId, String commentId);
}
