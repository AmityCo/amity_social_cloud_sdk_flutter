import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data_source/local/db_adapter/reaction_related_db_adapter.dart';
import 'package:amity_sdk/src/data/data_source/local/hive_entity/post_hive_entity_5.dart';

abstract class PostDbAdapter with ReactionRelatedDBAdapter<PostHiveEntity> {
  Future savePostEntity(PostHiveEntity data);
  Future deletePostEntity(PostHiveEntity data);
  Future deletePostEntitiesByTargetId(String targetId);
  PostHiveEntity? getPostEntity(String postId);

  Stream<PostHiveEntity> listenPostEntity(String postId);

  Future updateComment(String postId, String commentId);

  Stream<List<PostHiveEntity>> listenPostEntities(
      RequestBuilder<GetPostRequest> request);

  List<PostHiveEntity> getPostEntities(
    RequestBuilder<GetPostRequest> request);

  Stream<List<PostHiveEntity>> listenAllPostEntities();

  List<PostHiveEntity> getAllPostEntities();
  
  Future savePostEntities(List<PostHiveEntity> data);
}
