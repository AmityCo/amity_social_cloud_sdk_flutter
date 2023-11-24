import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/converter/stream/get_stream_response_extension.dart';
import 'package:amity_sdk/src/data/response/get_streams_response.dart';
import 'package:amity_sdk/src/domain/usecase/stream/stream_has_local_usecase.dart';

class StreamEventListener extends SocketEventListener {
  @override
  String getEventName() {
    return '';
  }

  @override
  void processEvent(Map<String, dynamic> json) {
    final data = GetStreamsResponse.fromEvent(json);
    data.saveToDb(serviceLocator());
  }

  @override
  bool shouldProcessEvent(Map<String, dynamic> json) {
    final data = GetStreamsResponse.fromJson(json);
    if(data.streams.isNotEmpty) {
      if(data.streams[0].streamId!=null){
        return _hasLocalStream(data.streams[0].streamId!);
      }else{
        return false;
      }
    } else {
      return false;
    }
  }

  bool _hasLocalStream(String messageId) {
    return serviceLocator<StreamHasLocalUseCase>().get(messageId);
  }


}