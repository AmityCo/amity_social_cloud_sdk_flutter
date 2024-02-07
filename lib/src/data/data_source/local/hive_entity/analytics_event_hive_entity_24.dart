
import 'package:amity_sdk/src/data/data.dart';
import 'package:hive/hive.dart';


part 'analytics_event_hive_entity_24.g.dart';

@HiveType(typeId: 24)
class AnalyticsEventHiveEntity  extends EkoObject{

  String? eventId;

  String? userId;

  String? contentId;

  String? contentType;

  String? activityType;

  String? syncPriority;
  
  @override
  String? getId() {
    return eventId;
  }


}