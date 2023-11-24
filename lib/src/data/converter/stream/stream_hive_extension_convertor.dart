import 'package:amity_sdk/src/core/enum/amity_broadcast_resolution.dart';
import 'package:amity_sdk/src/core/enum/amity_stream_status.dart';
import 'package:amity_sdk/src/core/model/api_request/stream_query_request.dart';
import 'package:amity_sdk/src/data/data_source/local/hive_entity/stream_hive_entity_22.dart';
import 'package:amity_sdk/src/domain/model/amity_stream/amity_stream.dart';

extension StreamHiveExtensionConverter on StreamHiveEntity {
  AmityStream convertToAmityStream() {
    BroadcasterData broadcasterData = BroadcasterData();
    broadcasterData.url = broadcasterUrl?.url;
    AmityBroadcastResolution? aResolution = null;
    if (resolution != null) {
      aResolution = AmityBroadcastResolutionExtension.enumOf(resolution!);
    }

    AmityStreamStatus? aStatus = null;
    if (status != null) {
      aStatus = AmityStreamStatusExtension.enumOf(status!);
    }

    WatcherData? aWatcherData = null;
    if (watcherUrl != null) {
      aWatcherData = WatcherData(watcherUrl!);
    }

    List<AmityRecordingData>? recordings;
    recordings = this.recordings?.map((e) => AmityRecordingData(e)).toList();
    return AmityStream()
      ..streamId = streamId
      ..description = description
      ..endedAt = endedAt
      ..isDeleted = isDeleted
      ..isLive = isLive
      ..resolution = aResolution
      ..startedAt = startedAt
      ..status = aStatus
      ..title = title
      ..userId = userId
      ..updatedAt = updatedAt
      ..createdAt = createdAt
      ..thumbnailFileId = thumbnailFileId
      ..watcherData = aWatcherData
      ..broadcasterData = broadcasterData
      ..recordings = recordings;
  }

  bool isMatchingFilter(StreamQueryRequest filter) {
    return _isDeletedCondition(filter) && _isLiveStream(filter);
  }

  bool _isDeletedCondition(StreamQueryRequest request) {
    return request.isDeleted == null || request.isDeleted == isDeleted;
  }

  bool _isLiveStream(StreamQueryRequest request) {
    bool isLiveCheck = false;
    if(isLive == request.isLive){
      isLiveCheck = true;
    }

    if(status == request.statuses?.first){
      isLiveCheck = true;
    }

    return isLiveCheck;
  }
}
