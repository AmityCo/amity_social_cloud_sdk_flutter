import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/engine/analytics/analytics_service.dart';

class MarkPostAsViewedUseCase extends UseCase<void , String>{

  AnalyticsService analyticsService = AnalyticsService();
  @override
  Future<void> get(String params) {
    analyticsService.markPostAsViewed(params);
    return Future.value();
  }

}