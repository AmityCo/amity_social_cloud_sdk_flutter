import 'package:amity_sdk/src/data/data.dart';
import 'package:hive/hive.dart';

class PostDbAdapterImpl extends PostDbAdapter {
  PostDbAdapterImpl({required this.dbClient});
  final DBClient dbClient;
  late Box box;
  Future<PostDbAdapter> init() async {
    Hive.registerAdapter(PostHiveEntityAdapter(), override: true);
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
  PostHiveEntity? getPostEntity(String postId) {
    return box.get(postId);
  }

  @override
  Stream<PostHiveEntity> listenPostEntity(String postId) {
    return box.watch(key: postId).map((event) => event.value);
  }

  @override
  Future updateComment(String postId, String commentId) async {
    final postHiveEntity = getPostEntity(postId);
    if (postHiveEntity != null) {
      postHiveEntity.comments ?? [].add(commentId);
      postHiveEntity.commentsCount = ((postHiveEntity.commentsCount) ?? 0) + 1;
      await postHiveEntity.save();
    }
    return;
  }
}
