import 'package:amity_sdk/data/data_source/local/hive_entity/post_hive_entity_5.dart';

abstract class PostDbAdapter {
  Future savePostEntity(PostHiveEntity data);
  Future deletePostEntity(PostHiveEntity data);
  PostHiveEntity getPostEntity(String postId);
}
