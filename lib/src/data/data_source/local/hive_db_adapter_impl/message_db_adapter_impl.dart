import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/enum/amity_message_sync_state.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:hive/hive.dart';

/// MessageDbAdapterImpl
class MessageDbAdapterImpl extends MessageDbAdapter {
  /// [MessageDbAdapterImpl]
  MessageDbAdapterImpl({required this.dbClient});

  /// Db Client
  final DBClient dbClient;

  /// Message Box
  late Box<MessageHiveEntity> box;

  /// Init [MessageDbAdapterImpl]
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
  MessageHiveEntity? getMessageEntity(String messageId) {
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
        .where((message) =>
                (message is MessageHiveEntity) &&
                message.channelId == request.channelId &&
                _isDeletedCondition(message, request) &&
                _parentCondition(message, request)
            //missing tags
            )
        .map((e) => e as MessageHiveEntity)
        .toList());
  }

  bool _isDeletedCondition(
      MessageHiveEntity message, MessageQueryRequest request) {
    if (request.isDeleted == null) {
      //if isDeleted is not defined, return both isDeleted == true && isDeleted == false
      return true;
    } else {
      //if isDeleted is defined, return request.isDeleted messages only
      return message.isDeleted == request.isDeleted;
    }
  }

  bool _parentCondition(
      MessageHiveEntity message, MessageQueryRequest request) {
    if (request.parentId != null && request.filterByParentId == true) {
      // if filterByParentId, return message with the parentId
      return message.parentId == request.parentId;
    } else {
      // else retur  parent messages only, which parentId must be null
      return message.parentId == null;
    }
  }

  @override
  List<MessageHiveEntity> getUnsendMessages() {
    return box.values
        .where((element) => element.syncState == AmityMessageSyncState.SYNCING)
        .toList();
  }
}
