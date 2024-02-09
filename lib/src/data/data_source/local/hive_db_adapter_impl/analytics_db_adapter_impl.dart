import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/data/data_source/local/db_adapter/analytics_db_adapter.dart';
import 'package:amity_sdk/src/data/data_source/local/hive_entity/analytics_event_hive_entity_24.dart';
import 'package:collection/collection.dart';
import 'package:hive/hive.dart';

class AnalyticsDbAdapterImpl extends AnalyticsDbAdapter{

  // Db Client
  final DBClient dbClient;

  /// Box
  late Box<AnalyticsEventHiveEntity> box;

  AnalyticsDbAdapterImpl({required this.dbClient});

  Future<AnalyticsDbAdapterImpl> init() async {
    Hive.registerAdapter(AnalyticsEventHiveEntityAdapter(), override: true);
    box = await Hive.openBox<AnalyticsEventHiveEntity>('analytics_db');
    return this;
  }

  @override
  void deleteAll() {
    for (var element in box.values) {
      element.delete();
    }
  }

  @override
  Future deleteOldestEvent() async {
    box.values.last.delete();
  }

  @override
  Future<List<AnalyticsEventHiveEntity>> getAnalyticEvents(String userId, String syncPriority, int limit)  async {
    var list =  box.values.where((element) => userId == element.userId && syncPriority == syncPriority ).take(limit).toList();
    list.sort((a, b) => a.getCreatedAt()!.compareTo(b.getCreatedAt()!) * -1);
    return list;
  }

  @override
  Future<int> getAnalyticEventsCount() async {
    return box.values.toList().length;
  }

  @override
  AnalyticsEventHiveEntity? getByIdNow(String id) {
    var recentEvent = box.values.firstWhereOrNull((element) => element.contentId == id );
    return recentEvent; 
  }
  
  @override
  Future saveAnalyticsEvents(List<AnalyticsEventHiveEntity> entities) async {
    for (var entity in entities){
      box.put(entity.eventId, entity);  
    }
  }
  
  @override
  Future deleteAnalyticsEvents(List<AnalyticsEventHiveEntity> entities) async {
    for (var entity in entities){
      box.delete(entity.eventId
      );  
    }
  }

}