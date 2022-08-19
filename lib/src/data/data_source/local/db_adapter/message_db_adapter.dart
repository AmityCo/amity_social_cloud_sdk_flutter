import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data_source/local/hive_entity/message_hive_entity_18.dart';

/// Message Collection Adater
abstract class MessageDbAdapter {
  /// Save Message Entity
  Future saveMessageEntity(MessageHiveEntity data);

  /// Delete Message Entity
  Future deleteMessageEntity(MessageHiveEntity data);

  /// Get Message Entity
  MessageHiveEntity? getMessageEntity(String messageId);

  /// Listen Message Entity
  Stream<MessageHiveEntity> listenMessageEntity(String messageId);

  /// Listen Message Entities
  Stream<List<MessageHiveEntity>> listenMessageEntities(
      MessageQueryRequest request);

  /// Get all the messages which have SYNCING status.
  List<MessageHiveEntity> getUnsendMessages();
}
