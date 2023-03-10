import 'package:amity_sdk/src/data/data.dart';
import 'package:hive/hive.dart';

class CommentDbAdapterImpl extends CommentDbAdapter {
  final DBClient dbClient;

  CommentDbAdapterImpl({required this.dbClient});
  late Box box;
  Future<CommentDbAdapterImpl> init() async {
    Hive.registerAdapter(CommentHiveEntityAdapter(), override: true);
    box = await Hive.openBox<CommentHiveEntity>('comment_db');
    return this;
  }

  @override
  CommentHiveEntity? getCommentEntity(String id) {
    return box.get(id);
  }

  @override
  Future saveCommentEntity(CommentHiveEntity entity) async {
    await box.put(entity.commentId, entity);
  }

  @override
  Stream<CommentHiveEntity> listenCommentEntity(String commentId) {
    return box.watch(key: commentId).map((event) => event.value);
  }

  @override
  Future updateChildComment(String parentCommentId, String commentId) async {
    CommentHiveEntity commentHiveEntity = getCommentEntity(parentCommentId)!;
    commentHiveEntity.children!.add(commentId);
    commentHiveEntity.childrenNumber =
        ((commentHiveEntity.childrenNumber) ?? 0) + 1;
    await commentHiveEntity.save();
    return;
  }
}
