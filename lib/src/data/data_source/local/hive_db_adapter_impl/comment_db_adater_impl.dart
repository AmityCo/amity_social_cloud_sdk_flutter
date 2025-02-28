import 'package:amity_sdk/src/core/model/api_request/get_comment_request.dart';
import 'package:amity_sdk/src/core/utils/live_collection.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:hive/hive.dart';

class CommentDbAdapterImpl extends CommentDbAdapter {
  final DBClient dbClient;

  CommentDbAdapterImpl({required this.dbClient});
  late Box<CommentHiveEntity> box;
  Future<CommentDbAdapterImpl> init() async {
    Hive.registerAdapter(CommentHiveEntityAdapter(), override: true);
    box = await Hive.openBox<CommentHiveEntity>('comment_db');
    return this;
  }

  @override
  CommentHiveEntity? getCommentEntity(String id) {
    var comments = box.values
        .where(
          (element) => element.commentId == id,
        )
        .toList();
    if (comments.isEmpty) {
      return null;
    }
    return comments.first;
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
    final commentHiveEntity = getCommentEntity(parentCommentId);
    if (commentHiveEntity != null) {
      commentHiveEntity.children!.add(commentId);
      commentHiveEntity.childrenNumber =
          ((commentHiveEntity.childrenNumber) ?? 0) + 1;
      await commentHiveEntity.save();
    }

    return;
  }

  @override
  Stream<List<CommentHiveEntity>> listenCommentEntities(
      RequestBuilder<GetCommentRequest> request) {
    return box.watch().map((event) =>
      box.values
        .where((comment) => comment.isMatchingFilter(request.call()))
        .toList()
    );
  }
  
  @override
  Future saveEntity(CommentHiveEntity entity) async {
    await saveCommentEntity(entity);
  }

  @override
  Future<CommentHiveEntity?> getEntity(String id) async {
    return getCommentEntity(id);
  }
}
