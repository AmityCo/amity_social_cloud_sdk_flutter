import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk_api/amity_sdk_api.dart';

import '../core/core.dart';
import '../domain/usecase/stream/stream_get_local_usecase.dart';

class StreamFunction extends StreamFunctionInterface {
  @override
  Future<PartialStreamData> getStreamData(String streamId) async  {
    AmityStream stream = serviceLocator<StreamGetLocalUseCase>().get(streamId);
    List<String> urls = List.empty(growable: true);
    if (stream.isLive ?? false) {
      urls.add(stream.watcherData!.getUrl(AmityWatcherDataFormat.rtmp));
    } else {
      urls.add(stream.recordings![0].getUrl(AmityRecordingDataFormat.mp4));

      if (stream.recordings != null) {
        for (var recording in stream.recordings!) {
          urls.add(recording.getUrl(AmityRecordingDataFormat.mp4));
        }
      }
    }
    return Future.value(PartialStreamData(
      isLive: stream.isLive ?? false,
      streamId: streamId,
      resolution: stream.resolution?.name ?? "",
      watchingUrls: urls,
    ));
  }
}
