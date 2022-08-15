import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:dio/dio.dart';

/// [MessageApiInterfaceImpl]
class MessageApiInterfaceImpl extends MessageApiInterface {
  /// Init Message  api client
  MessageApiInterfaceImpl({required this.httpApiClient});

  /// Http clinet to make API request
  final HttpApiClient httpApiClient;
  @override
  Future<CreateMessageResponse> messageQuery(
      MessageQueryRequest request) async {
    try {
      final data = await httpApiClient()
          .get(MESSAGE_V3, queryParameters: request.toJson());
      return CreateMessageResponse.fromJson(data.data);
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }
}
