class AnalyticsEventRequest {
    String? contentId;
    String? contentType;
    String? activityType;
    DateTime? timestamp;

    AnalyticsEventRequest({this.contentId, this.contentType, this.activityType, this.timestamp}); 

    AnalyticsEventRequest.fromJson(Map<String, dynamic> json) {
        contentId = json['contentId'];
        contentType = json['contentType'];
        activityType = json['activityType'];
        timestamp = json['timestamp'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data['contentId'] = contentId;
        data['contentType'] = contentType;
        data['activityType'] = activityType;
        data['timestamp'] = timestamp?.toUtc().toIso8601String();
        
        // .toIso8601String();
        return data;
    }
}