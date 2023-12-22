import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data_source/local/hive_entity/post_hive_entity_5.dart';

abstract class PostDbAdapter {
  Future savePostEntity(PostHiveEntity data);
  Future deletePostEntity(PostHiveEntity data);
  PostHiveEntity? getPostEntity(String postId);

  Stream<PostHiveEntity> listenPostEntity(String postId);

  Future updateComment(String postId, String commentId);

  Stream<List<PostHiveEntity>> listenPostEntities(
      RequestBuilder<GetPostRequest> request);

}
