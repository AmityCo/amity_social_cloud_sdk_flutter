import 'package:amity_sdk/data/data.dart';
import 'package:amity_sdk/data/data_source/local/db_adapter/comment_db_adapter.dart';
import 'package:amity_sdk/data/data_source/local/hive_entity/comment_hive_entity_6.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CommentDbAdapterImpl extends CommentDbAdapter {
  final DBClient dbClient;

  CommentDbAdapterImpl({required this.dbClient});
  late Box box;
  Future<CommentDbAdapterImpl> init() async {
    Hive.registerAdapter(CommentHiveEntityAdapter());
    box = await Hive.openBox<CommentHiveEntity>('comment_db');
    return this;
  }

  @override
  CommentHiveEntity getCommentEntity(String id) {
    return box.get(id);
  }

  @override
  Future saveCommentEntity(CommentHiveEntity entity) async {
    await box.put(entity.commentId, entity);
  }
}
