import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/model/api_request/stream_query_request.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/data/data_source/remote/api_interface/stream_api_interface.dart';
import 'package:amity_sdk/src/data/response/get_streams_response.dart';
import 'package:dio/dio.dart';

class StreamApiInterfaceImpl extends StreamApiInterface{

  StreamApiInterfaceImpl({required this.httpApiClient});

  /// Http clinet to make API request
  final HttpApiClient httpApiClient;

  @override
  Future<GetStreamsResponse> getStreams(StreamQueryRequest request) async {
    try {
      final data = await httpApiClient()
          .get(STREAM_V3, queryParameters: request.toJson());
      return GetStreamsResponse.fromJson(data.data);
    } on DioException catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }
  
  @override
  Future<GetStreamsResponse> getStream(String streamId) async {
    try {
      final data = await httpApiClient()
          .get('$STREAM_V3/$streamId');
      return GetStreamsResponse.fromJson(data.data);
    } on DioException catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }

  }
}