import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/data/data_source/local/db_adapter/story_target_db_adapter.dart';
import 'package:amity_sdk/src/data/data_source/local/hive_entity/story_target_hive_entity_28.dart';
import 'package:hive/hive.dart';

class StoryTargetDbAdapterImpl extends StoryTargetDbAdapter {

  /// Db Client
  final DBClient dbClient;

  /// Story Target Box
  late Box<StoryTargetHiveEntity> box;

  StoryTargetDbAdapterImpl({required this.dbClient});

  /// Init [StoryTargetDbAdapterImpl]
  Future<StoryTargetDbAdapter> init() async {
    Hive.registerAdapter(StoryTargetHiveEntityAdapter(), override: true);
    box = await Hive.openBox<StoryTargetHiveEntity>('Story_Target_db');
    return this;
  }

  @override
  Future deleteAllStoryTargetEntity() async  {
    for (var element in box.values) {
      element.delete();
    }
  }

  @override
  Future deleteStoryTargetEntity(String targetId) async {
    return box.delete(targetId);
  }

  @override
  StoryTargetHiveEntity? getStoryTargetEntity(String targetId) {
    return box.values.firstWhere((element) => element.targetId == targetId);
  }

  @override
  Future saveStoryTargetEntity(StoryTargetHiveEntity data) async {
    return box.put(data.targetId, data);
  }


}