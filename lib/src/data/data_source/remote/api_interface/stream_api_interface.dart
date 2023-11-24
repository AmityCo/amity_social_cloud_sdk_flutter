import 'package:amity_sdk/src/core/model/api_request/stream_query_request.dart';
import 'package:amity_sdk/src/data/response/get_streams_response.dart';

abstract class StreamApiInterface{
  Future<GetStreamsResponse> getStreams( StreamQueryRequest request);
  Future<GetStreamsResponse> getStream( String streamId);
}