import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/model/api_request/stream_query_request.dart';
import 'package:amity_sdk/src/domain/model/amity_stream/amity_stream.dart';


abstract class StreamRepo{
  Future<PageListData<List<AmityStream>, String>> queryStream( StreamQueryRequest request);
  Stream<List<AmityStream>> listenStreams(RequestBuilder<StreamQueryRequest> request);
  Future<AmityStream> getStream(String streamId);
  Future<AmityStream> getStreamFromDb(String streamId);
  bool hasLocal(String streamId);
  AmityStream getLocal(String streamId);
}