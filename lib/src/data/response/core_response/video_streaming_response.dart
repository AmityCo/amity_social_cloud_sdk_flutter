class VideoStreamingResponse {
  VideoStreamingResponse({
    required this.streamId,
    required this.userId,
    required this.thumbnailFileId,
    required this.title,
    required this.status,
    required this.isLive,
    required this.isDeleted,
    required this.description,
    required this.platform,
    required this.startedAt,
    required this.endedAt,
    required this.createdAt,
    required this.updatedAt,
    // required this.metadata,
    required this.resolution,
    required this.streamerUrl,
    required this.recordings,
    required this.watcherUrl,
  });

  final String? streamId;
  final String? userId;
  final String? thumbnailFileId;
  final String? title;
  final String? status;
  final bool? isLive;
  final bool? isDeleted;
  final String? description;
  final Platform? platform;
  final DateTime? startedAt;
  final DateTime? endedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  // final DataClass metadata;
  final String? resolution;
  final ErUrl? streamerUrl;
  final List<Map<String, Recording>>? recordings;
  final Map<String, ErUrl>? watcherUrl;

  factory VideoStreamingResponse.fromJson(Map<String, dynamic> json) =>
      VideoStreamingResponse(
        streamId: json["streamId"],
        userId: json["userId"],
        thumbnailFileId: json["thumbnailFileId"],
        title: json["title"],
        status: json["status"],
        isLive: json["isLive"],
        isDeleted: json["isDeleted"],
        description: json["description"],
        platform: json["platform"] == null
            ? null
            : Platform.fromJson(json["platform"]),
        startedAt: json["startedAt"] == null
            ? null
            : DateTime.tryParse(json["startedAt"]),
        endedAt:
            json["endedAt"] == null ? null : DateTime.tryParse(json["endedAt"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.tryParse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.tryParse(json["updatedAt"]),
        // metadata: DataClass.fromJson(json["metadata"]),
        resolution: json["resolution"],
        streamerUrl: json["platform"] == null
            ? null
            : ErUrl.fromJson(json["streamerUrl"]),
        recordings: json["recordings"] == null
            ? null
            : List<Map<String, Recording>>.from(json["recordings"].map((x) =>
                Map.from(x).map((k, v) =>
                    MapEntry<String, Recording>(k, Recording.fromJson(v))))),
        watcherUrl: json["watcherUrl"] == null
            ? null
            : Map.from(json["watcherUrl"])
                .map((k, v) => MapEntry<String, ErUrl>(k, ErUrl.fromJson(v))),
      );

  Map<String, dynamic> toJson() => {
        "streamId": streamId,
        "userId": userId,
        "thumbnailFileId": thumbnailFileId,
        "title": title,
        "status": status,
        "isLive": isLive,
        "isDeleted": isDeleted,
        "description": description,
        "platform": platform?.toJson(),
        "startedAt": startedAt?.toIso8601String(),
        "endedAt": endedAt?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        // "metadata": metadata.toJson(),
        "resolution": resolution,
        "streamerUrl": streamerUrl?.toJson(),
        "recordings": recordings == null
            ? null
            : List<dynamic>.from(recordings!.map((x) => Map.from(x)
                .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())))),
        "watcherUrl": watcherUrl == null
            ? null
            : Map.from(watcherUrl!)
                .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
      };
}

class Platform {
  Platform({
    required this.name,
    required this.version,
  });

  final String name;
  final String version;

  factory Platform.fromJson(Map<String, dynamic> json) => Platform(
        name: json["name"],
        version: json["version"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "version": version,
      };
}

class Recording {
  Recording({
    required this.url,
    required this.duration,
    required this.startTime,
    required this.stopTime,
  });

  final String? url;
  final double? duration;
  final double? startTime;
  final double? stopTime;

  factory Recording.fromJson(Map<String, dynamic> json) => Recording(
        url: json["url"],
        duration: double.tryParse('${json["duration"]}'),
        startTime: double.tryParse('${json["startTime"]}'),
        stopTime: double.tryParse('${json["stopTime"]}'),
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "duration": duration,
        "startTime": startTime,
        "stopTime": stopTime,
      };
}

class ErUrl {
  ErUrl({
    required this.url,
    required this.components,
  });

  final String url;
  final Components components;

  factory ErUrl.fromJson(Map<String, dynamic> json) => ErUrl(
        url: json["url"],
        components: Components.fromJson(json["components"]),
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "components": components.toJson(),
      };
}

class Components {
  Components({
    required this.origin,
    required this.appName,
    required this.streamName,
    required this.query,
  });

  final String origin;
  final String appName;
  final String streamName;
  final String query;

  factory Components.fromJson(Map<String, dynamic> json) => Components(
        origin: json["origin"],
        appName: json["appName"],
        streamName: json["streamName"],
        query: json["query"],
      );

  Map<String, dynamic> toJson() => {
        "origin": origin,
        "appName": appName,
        "streamName": streamName,
        "query": query,
      };
}
