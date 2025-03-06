import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data_source/local/db_adapter/reaction_related_db_adapter.dart';
import 'package:amity_sdk/src/data/data_source/local/hive_entity/comment_hive_entity_6.dart';

abstract class CommentDbAdapter with ReactionRelatedDBAdapter<CommentHiveEntity> {
  Future saveCommentEntity(CommentHiveEntity entity);
  CommentHiveEntity? getCommentEntity(String id);
  Stream<CommentHiveEntity> listenCommentEntity(String commentId);

  Future updateChildComment(String parentCommentId, String commentId);

  Stream<List<CommentHiveEntity>> listenCommentEntities(
      RequestBuilder<GetCommentRequest> request);

  List<CommentHiveEntity> getCommentEntities(RequestBuilder<GetCommentRequest> request);
}
