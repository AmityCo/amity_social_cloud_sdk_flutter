import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/data/data_source/local/db_adapter/message_db_adapter.dart';
import 'package:amity_sdk/src/data/data_source/local/hive_entity/message_hive_entity_18.dart';
import 'package:hive/hive.dart';

class MessageDbAdapterImpl extends MessageDbAdapter {
  MessageDbAdapterImpl({required this.dbClient});
  final DBClient dbClient;
  late Box box;
  Future<MessageDbAdapter> init() async {
    Hive.registerAdapter(MessageHiveEntityAdapter(), override: true);
    box = await Hive.openBox<MessageHiveEntity>('Message_db');
    return this;
  }

  @override
  Future deleteMessageEntity(MessageHiveEntity data) async {
    await box.delete(data.messageId);
  }

  @override
  Future saveMessageEntity(MessageHiveEntity data) async {
    await box.put(data.messageId, data);
  }

  @override
  MessageHiveEntity getMessageEntity(String messageId) {
    return box.get(messageId);
  }

  @override
  Stream<MessageHiveEntity> listenMessageEntity(String messageId) {
    return box.watch(key: messageId).map((event) => event.value);
  }

  @override
  Stream<List<MessageHiveEntity>> listenMessageEntities(
      MessageQueryRequest request) {
    return box.watch().map((event) => box.values
        .where((element) =>
                (element is MessageHiveEntity) &&
                element.channelId == request.channelId &&
                element.parentId == null
            //missing tags and isDeleted
            )
        .map((e) => e as MessageHiveEntity)
        .toList());
  }
}
