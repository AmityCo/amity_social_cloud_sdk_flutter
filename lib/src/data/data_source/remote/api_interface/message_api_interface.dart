import 'package:amity_sdk/src/core/model/api_request/message_query_request.dart';
import 'package:amity_sdk/src/data/response/create_message_response.dart';

/// Message API Interface
abstract class MessageApiInterface {
  /// Message Query
  Future<CreateMessageResponse> messageQuery(MessageQueryRequest request);
}
