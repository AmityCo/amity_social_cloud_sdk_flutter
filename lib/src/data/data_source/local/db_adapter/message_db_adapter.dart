import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data_source/local/hive_entity/message_hive_entity_18.dart';

abstract class MessageDbAdapter {
  Future saveMessageEntity(MessageHiveEntity data);
  Future deleteMessageEntity(MessageHiveEntity data);
  MessageHiveEntity? getMessageEntity(String messageId);
  Stream<MessageHiveEntity> listenMessageEntity(String messageId);
  Stream<List<MessageHiveEntity>> listenMessageEntities(
      MessageQueryRequest request);
  Future deleteMessagesByChannelId(String channelId);
}
