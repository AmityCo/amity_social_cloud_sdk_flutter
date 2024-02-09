import 'package:amity_sdk/src/data/data_source/local/hive_entity/analytics_event_hive_entity_24.dart';

abstract class AnalyticsDbAdapter {
  void deleteAll();
  Future<List<AnalyticsEventHiveEntity>> getAnalyticEvents(
      String userId, String syncPriority, int limit);
  Future<int> getAnalyticEventsCount();
  Future deleteOldestEvent();
  AnalyticsEventHiveEntity? getByIdNow(String id);
  Future saveAnalyticsEvents(List<AnalyticsEventHiveEntity> entities);
  Future deleteAnalyticsEvents(List<AnalyticsEventHiveEntity> entities);
}
