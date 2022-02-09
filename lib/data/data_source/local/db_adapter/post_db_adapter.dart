import 'package:amity_sdk/data/data_source/local/hive_entity/post_hive_entity.dart';

abstract class PostDbAdapter {
  void savePost(PostHiveEntity data);
  void deletePost(PostHiveEntity data);
}
