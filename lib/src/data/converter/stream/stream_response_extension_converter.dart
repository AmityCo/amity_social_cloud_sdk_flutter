import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/data/data_source/local/hive_entity/stream_hive_entity_22.dart';

extension StreamResponseExtensionConverter on VideoStreamingResponse {
  StreamHiveEntity convertToStreamHiveEntity() {
    return StreamHiveEntity(
      streamId:  streamId,
      userId: userId,
      thumbnailFileId: thumbnailFileId,
      title: title,
      status: status,
      isLive: isLive,
      isDeleted: isDeleted,
      description: description,
      startedAt: startedAt,
      endedAt: endedAt,
      createdAt: createdAt,
      updatedAt: updatedAt,
      resolution: resolution,
      broadcasterUrl: streamerUrl,
      recordings: recordings,
      watcherUrl: watcherUrl,

    );
  }
}