import 'package:amity_sdk/src/data/data.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'stream_hive_entity_22.g.dart';

@HiveType(typeId: 22)
class StreamHiveEntity extends HiveObject {
  String? streamId;

  String? title;

  String? description;

  String? metadta;

  bool? isReconnecting;

  String? thumbnailFileId;

  String? userId;

  String? status;

  Map<String, ErUrl>? watcherUrl;

  ErUrl? broadcasterUrl;

  List<Map<String, Recording>>? recordings;

  String? resolution;

  bool? isDeleted;

  bool? isLive;

  DateTime? startedAt;

  DateTime? endedAt;

  DateTime? createdAt;

  DateTime? updatedAt;

  StreamHiveEntity({
    this.streamId,
    this.title,
    this.description,
    this.metadta,
    this.isReconnecting,
    this.thumbnailFileId,
    this.userId,
    this.status,
    this.watcherUrl,
    this.broadcasterUrl,
    this.recordings,
    this.resolution,
    this.isDeleted,
    this.isLive,
    this.createdAt,
    this.updatedAt,
    this.endedAt,
    this.startedAt,
  });

  StreamHiveEntity copyWith({
    String? streamId,
    String? title,
    String? description,
    String? metadta,
    bool? isReconnecting,
    String? thumbnailFileId,
    String? userId,
    String? status,
    Map<String, ErUrl>? watcherUrl,
    ErUrl? broadcasterUrl,
    List<Map<String, Recording>>? recordings,
    String? resolution,
    bool? isDeleted,
    bool? isLive,
    DateTime? startedAt,
    DateTime? endedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return StreamHiveEntity(
      streamId: streamId ?? this.streamId,
      title: title ?? this.title,
      description: description ?? this.description,
      metadta: metadta ?? this.metadta,
      isReconnecting: isReconnecting ?? this.isReconnecting,
      thumbnailFileId: thumbnailFileId ?? this.thumbnailFileId,
      userId: userId ?? this.userId,
      status: status ?? this.status,
      watcherUrl: watcherUrl ?? this.watcherUrl,
      broadcasterUrl: broadcasterUrl ?? this.broadcasterUrl,
      recordings: recordings ?? this.recordings,
      resolution: resolution ?? this.resolution,
      isDeleted: isDeleted ?? this.isDeleted,
      isLive: isLive ?? this.isLive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      endedAt: endedAt ?? this.endedAt,
      startedAt: startedAt ?? this.startedAt,
    );
  }
}
