import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/core/engine/analytics/analytics_event_sync_priority.dart';
import 'package:amity_sdk/src/core/model/api_request/analytics_event_request.dart';
import 'package:amity_sdk/src/core/model/api_request/get_reach_user_request.dart';
import 'package:amity_sdk/src/core/model/api_request/send_analytics_event_request.dart';
import 'package:amity_sdk/src/core/utils/page_list_data.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/data/data_source/local/hive_entity/analytics_event_hive_entity_24.dart';
import 'package:amity_sdk/src/data/data_source/remote/api_interface/analytics_api_interface.dart';
import 'package:amity_sdk/src/domain/repo/analytics_repo.dart';
import 'package:uuid/uuid.dart';

class AnalytcisRepoImpl extends AnalyticsRepo {
  static int MAX_ANALYTIC_EVENTS = 1000;

  ///Api Interface
  final AnalyticsApiInterface analyticsApiInterface;

  ///Db Adapter
  final DbAdapterRepo dbAdapterRepo;

  AnalytcisRepoImpl(
      {required this.analyticsApiInterface, required this.dbAdapterRepo});

  @override
  void deleteAllAnalyticsEvents() {
    dbAdapterRepo.analyticsDbAdapter.deleteAll();
  }

  @override
  Future saveAnalyticsEvent(String contentId, String contentType,
      String activityType, AnalyticsEventSyncPriority syncPriority) async {
    var recentEvent = dbAdapterRepo.analyticsDbAdapter.getByIdNow(contentId);
    if (recentEvent != null) {
      if (DateTime.now().difference(recentEvent.getCreatedAt()!).inSeconds <
          5) {
        return;
      }
    }

    var count = await dbAdapterRepo.analyticsDbAdapter.getAnalyticEventsCount();

    if (count >= MAX_ANALYTIC_EVENTS) {
      await dbAdapterRepo.analyticsDbAdapter.deleteOldestEvent();
    }
    var event =
        createAnalyticEvent(contentId, contentType, activityType, syncPriority);
    await dbAdapterRepo.analyticsDbAdapter.saveAnalyticsEvents([event]);
  }

  @override
  Future sendAnalyticsEvents(AnalyticsEventSyncPriority syncPriority) async {
    var events = await dbAdapterRepo.analyticsDbAdapter.getAnalyticEvents(
        AmityCoreClient.getUserId(), syncPriority.apiKey, 1000);
    if (events.isNotEmpty) {
      var request = createSendAnalyticEventsRequest(events);
      await analyticsApiInterface.sendAnalyticsEvents(request);
      await dbAdapterRepo.analyticsDbAdapter.deleteAnalyticsEvents(events);
    }
  }

  @override
  Future<PageListData<List<AmityUser>, String>> getViewedUsers(
      GetReachUserRequest request) async {

    UsersResponse data;
    
    if(request.postId!=null){
      data = await analyticsApiInterface.queryPostReachUsers(request);
    }else{
      data = await analyticsApiInterface.queryStorySeenUsers(request);
    }
     
    final userHiveEntities =
        data.users.map((e) => e.convertToUserHiveEntity()).toList();

    final fileHiveEntities =
        data.files.map((e) => e.convertToFileHiveEntity()).toList();

    for (var userEntity in userHiveEntities) {
      await dbAdapterRepo.userDbAdapter.saveUserEntity(userEntity);
    }
    for (var fileEntity in fileHiveEntities) {
      await dbAdapterRepo.fileDbAdapter.saveFileEntity(fileEntity);
    }

    final amityUsers =
        userHiveEntities.map((e) => e.convertToAmityUser()).toList();
    return PageListData(amityUsers, data.paging!.next ?? '');
  }

  AnalyticsEventHiveEntity createAnalyticEvent(
      String contentId,
      String contentType,
      String activityType,
      AnalyticsEventSyncPriority syncPriority) {
    return AnalyticsEventHiveEntity()
      ..eventId = const Uuid().v1()
      ..userId = AmityCoreClient.getUserId()
      ..contentId = contentId
      ..contentType = contentType
      ..activityType = activityType
      ..syncPriority = syncPriority.apiKey
      ..setCreatedAt(DateTime.now())
      ..setUpdatedAt(DateTime.now());
  }

  SendAnalyticsEventsRequest createSendAnalyticEventsRequest(
      List<AnalyticsEventHiveEntity> events) {
    final request = SendAnalyticsEventsRequest();
    request.activities = [];
    for (var element in events) {
      var activity = AnalyticsEventRequest()
        ..contentId = element.contentId
        ..contentType = element.contentType
        ..activityType = element.activityType
        ..timestamp = element.getCreatedAt();
      request.activities!.add(activity);
    }
    return request;
  }
}
