import 'package:amity_sdk/src/core/model/api_request/create_message_request.dart';
import 'package:amity_sdk/src/core/model/api_request/message_query_request.dart';
import 'package:amity_sdk/src/data/response/create_message_response.dart';

/// Message API Interface
abstract class MessageApiInterface {
  /// Message Query
  Future<CreateMessageResponse> messageQuery(MessageQueryRequest request);

  /// Create Message
  Future<CreateMessageResponse> createMessage(CreateMessageRequest request);

  /// Get Message
  Future<CreateMessageResponse> getMessage(String messageId);

  /// Delete Message
  Future deleteMessage(String messageId);

  /// flag Message
  Future<CreateMessageResponse> flagMessage(String messageId);

  /// unflag Message
  Future<CreateMessageResponse> unFlagMessage(String messageId);

  /// is flagged by me
  Future isFlaggedByMe(String messageId);
}
