import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/model/message/amity_message.dart';

/// Message Repo
abstract class MessageRepo {
  /// Query Message
  Future<PageListData<List<AmityMessage>, String>> queryMesssage(
      MessageQueryRequest request);

  /// Create Message
  Future<AmityMessage> createMessage(CreateMessageRequest request);

  /// Create File Message
  Future<AmityMessage> createFileMessage(CreateMessageRequest request);

  /// Listern Message
  Stream<List<AmityMessage>> listentMessages(MessageQueryRequest request);

  /// Has Local Message
  bool hasLocalMessage(String messageId);

  /// Get local Message
  AmityMessage? getLocalMessage(String messageId);
}
