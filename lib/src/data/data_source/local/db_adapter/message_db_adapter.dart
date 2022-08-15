import 'package:amity_sdk/src/data/data_source/local/hive_entity/message_hive_entity_18.dart';
import 'package:amity_sdk/src/data/data_source/local/hive_entity/post_hive_entity_5.dart';

abstract class MessageDbAdapter {
  Future saveMessageEntity(MessageHiveEntity data);
  Future deleteMessageEntity(MessageHiveEntity data);
  PostHiveEntity getMessageEntity(String messageId);

  Stream<PostHiveEntity> listenMessageEntity(String messageId);
}
