import 'package:amity_sdk/src/core/model/api_request/analytics_event_request.dart';

class SendAnalyticsEventsRequest {
    List<AnalyticsEventRequest?>? activities = [];

    SendAnalyticsEventsRequest({this.activities}); 

    SendAnalyticsEventsRequest.fromJson(Map<String, dynamic> json) {
        if (json['activities'] != null) {
         activities = <AnalyticsEventRequest>[];
         json['activities'].forEach((v) {
         activities!.add(AnalyticsEventRequest.fromJson(v));
        });
      }
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data['activities'] =activities != null ? activities!.map((v) => v?.toJson()).toList() : null;
        return data;
    }
}