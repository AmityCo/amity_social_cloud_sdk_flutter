import 'package:amity_sdk/src/data/data.dart';
import 'package:hive/hive.dart';

class ReactionDbAdapterImpl extends ReactionDbAdapter {
  ReactionDbAdapterImpl({required this.dbClient});
  final DBClient dbClient;
  late Box box;
  Future<ReactionDbAdapter> init() async {
    Hive.registerAdapter(ReactionHiveEntityAdapter(), override: true);
    box = await Hive.openBox<ReactionHiveEntity>('reaction_db');
    return this;
  }

  @override
  Future deleteReactionEntity(ReactionHiveEntity data) async {
    await box.delete(data.reactionId);
  }

  @override
  ReactionHiveEntity getReactionEntity(String reactionId) {
    return box.get(reactionId);
  }

  @override
  Future saveReactionEntity(ReactionHiveEntity data) async {
    await box.put(data.reactionId, data);
  }
}
