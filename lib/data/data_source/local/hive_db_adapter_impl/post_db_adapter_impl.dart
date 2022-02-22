import 'package:amity_sdk/data/data.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PostDbAdapterImpl extends PostDbAdapter {
  PostDbAdapterImpl({required this.dbClient});
  final DBClient dbClient;
  late Box box;
  Future<PostDbAdapter> init() async {
    Hive.registerAdapter(PostHiveEntityAdapter());
    box = await Hive.openBox<PostHiveEntity>('post_db');
    return this;
  }

  @override
  Future deletePostEntity(PostHiveEntity data) async {
    await box.delete(data.postId);
  }

  @override
  Future savePostEntity(PostHiveEntity data) async {
    await box.put(data.postId, data);
  }

  @override
  PostHiveEntity getPostEntity(String postId) {
    return box.get(postId);
  }
}
