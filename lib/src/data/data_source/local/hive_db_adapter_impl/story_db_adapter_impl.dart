import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/core/model/api_request/get_stories_by_target_request.dart';
import 'package:amity_sdk/src/data/converter/story/story_hive_extension_converter.dart';
import 'package:amity_sdk/src/data/data_source/data_source.dart';
import 'package:amity_sdk/src/data/data_source/local/db_adapter/story_db_adapter.dart';
import 'package:amity_sdk/src/data/data_source/local/hive_entity/story_hive_entity_27.dart';
import 'package:collection/collection.dart';
import 'package:hive/hive.dart';

class StoryDbAdapterImpl extends StoryDbAdapter {
  /// Db Client
  final DBClient dbClient;

  /// Message Box
  late Box<StoryHiveEntity> box;

  StoryDbAdapterImpl({required this.dbClient});

  /// Init [StoryDbAdapterImpl]
  Future<StoryDbAdapter> init() async {
    Hive.registerAdapter(StoryHiveEntityAdapter(), override: true);
    box = await Hive.openBox<StoryHiveEntity>('Story_db');
    return this;
  }

  @override
  Future deleteAllStoryEntity() async {
    for (var element in box.values) {
      element.delete();
    }
  }

  @override
  Future deleteStoryEntity(String storyId) async {
    await box.delete(storyId);
  }

  @override
  StoryHiveEntity? getStoryEntity(String storyId) {
    var storyEntity = box.values.firstWhere((element) => element.storyId == storyId);
    return storyEntity;
  }

  @override
  Future saveStoryEntity(StoryHiveEntity data) async {
    if (data.referenceId != null) {
      var storyEntity = box.values.firstWhereOrNull((element) => element.referenceId == data.referenceId);
      if (storyEntity != null) {
        storyEntity.delete();
      }
    }

    await box.put(data.storyId, data);
  }

  @override
  Future updateSyncState(String storyId, String syncState) {
    var storyEntity = box.values.firstWhere((element) => element.storyId == storyId);
    storyEntity.syncState = syncState;
    return box.put(storyId, storyEntity);
  }

  @override
  Stream<List<StoryHiveEntity>> listenStoryEntities(RequestBuilder<GetStoriesByTragetRequest> request) {
    return box.watch().map((event) => box.values.where((story) {
          return story.isMatchingFilter(request.call());
        }
            //missing tags
            ).toList());
  }

  @override
  Stream<StoryHiveEntity> listenPostEntity(String storyId) {
    return box.watch(key: storyId).map((event) => event.value);
  }

  @override
  DateTime? getHighestStoryExpiresAt(String targetType, String targetId, List<AmityStorySyncState> states) {
    var stories = box.values.where((element) {
      if (targetId == element.targetId &&
          targetType == element.targetType &&
          states.contains(
            AmityStorySyncStateExtension.enumOf(
              element.syncState,
            ),
          )) {
        return true;
      } else {
        return false;
      }
    });

    if(stories.isEmpty){
      return null;
    }
    var dateTime = stories.sorted((a, b) => a.expiresAt!.compareTo(b.expiresAt ?? DateTime.now()) * -1).first.expiresAt;
    
    return dateTime;
  }

  @override
  int getStoryCount(String targetType, String targetId, List<AmityStorySyncState> states) {
    var size = box.values.where(
      (element) {
        if (targetId == element.targetId &&
            targetType == element.targetType &&
            states.contains(
              AmityStorySyncStateExtension.enumOf(
                element.syncState,
              ),
            )) {
          return true;
        } else {
          return false;
        }
      },
    ).length;

    return size;
  }

  @override
  List<StoryHiveEntity> getStoriesBySyncStates(String targetType, String targetId, List<AmityStorySyncState> states) {
    var stories = box.values.where(
      (element) {
        if (targetId == element.targetId &&
            targetType == element.targetType &&
            states.contains(
              AmityStorySyncStateExtension.enumOf(
                element.syncState,
              ),
            )) {
          return true;
        } else {
          return false;
        }
      },
    ).toList();

    return stories;
  }
  
  @override
  Future<StoryHiveEntity?> getEntity(String id) async {
    return getStoryEntity(id);
  }
  
  @override
  Future saveEntity(StoryHiveEntity entity) {
    return saveStoryEntity(entity);
  }
}
