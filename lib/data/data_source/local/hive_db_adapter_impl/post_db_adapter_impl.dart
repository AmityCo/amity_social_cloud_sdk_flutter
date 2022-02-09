import 'package:amity_sdk/data/data_source/local/db_adapter/post_db_adapter.dart';
import 'package:amity_sdk/data/data_source/local/db_client/db_client.dart';
import 'package:amity_sdk/data/data_source/local/hive_entity/post_hive_entity.dart';

class PostDbAdapterImpl extends PostDbAdapter {
  PostDbAdapterImpl({required this.dbClient});
  final DBClient dbClient;
  @override
  void deletePost(PostHiveEntity data) {
    // TODO: implement deletePost
  }

  @override
  void savePost(PostHiveEntity data) {
    // TODO: implement savePost
  }
}
