import 'package:amity_sdk/src/core/core.dart';
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
    Hive.registerAdapter(MessageDataHiveEntityAdapter(), override: true);
    box = await Hive.openBox<MessageHiveEntity>('Message_db');
    return this;
  }

  @override
  Future deleteMessageEntity(MessageHiveEntity data) async {
    await box.delete(data.uniqueId);
  }

  @override
  Future deleteMessageEntityByUniqueId(String uniqueId) async {
    await box.delete(uniqueId);
  }

  @override
  Future saveMessageEntity(MessageHiveEntity data) async {
    await box.put(data.uniqueId, data);
  }

  @override
  MessageHiveEntity? getMessageEntity(String uniqueId) {
    return box.get(uniqueId);
  }

  @override
  Stream<MessageHiveEntity> listenMessageEntity(String uniqueId) {
    return box.watch(key: uniqueId).map((event) => event.value);
  }

  List<MessageHiveEntity> getMessageEntities(RequestBuilder<MessageQueryRequest> request) {
    return box.values
    .where((messages) => messages.isMatchingFilter(request.call()))
    .toList();
  }

  @override
  Future deleteMessagesByChannelId(String channelId) async {
    box.values
        .where((element) => element.subChannelId == channelId)
        .forEach((element) {
      box.delete(element.messageId);
    });
    return;
  }

  @override
  Stream<List<MessageHiveEntity>> listenMessageEntities(
      RequestBuilder<MessageQueryRequest> request) {
    // final req = request.call();
    return box.watch().map((event) => box.values
        .where((message) => message.isMatchingFilter(request.call())
            //missing tags
            )
        .toList());
  }

  @override
  List<MessageHiveEntity> getUnsendMessages() {
    return box.values
        .where((element) => element.syncState != AmityMessageSyncState.SYNCED.value)
        .toList();
  }

  @override
  int getHighestChannelSagment(String channelId) {
    return box.values
        .where((element) =>
            element.subChannelId == channelId &&
            element.parentId == null &&
            (element.syncState == AmityMessageSyncState.SYNCING.value ||
                element.syncState == AmityMessageSyncState.SYNCED.value))
        .fold<int>(
            0,
            (previousValue, element) => element.channelSegment! > previousValue
                ? element.channelSegment!
                : previousValue);
  }

  @override
  void softDeleteFromChannelByUserId(String channelId, String userId) {
    box.values
        .where((element) =>
            element.channelId == channelId && element.userId == userId)
        .forEach((element) {
      element.isDeleted = true;
      box.put(element.messageId, element);
    });
  }

  @override
  Future updateUnsyncedMessagesToFailed() async {
    final unsyncMessagesMap = {
      for (var element in box.values.where((element) => element.syncState != AmityMessageSyncState.SYNCED.value))
      if (element.uniqueId != null)
        element.uniqueId!: element..syncState = AmityMessageSyncState.FAILED.value
    };
    await box.putAll(unsyncMessagesMap);
  }

  @override
  Future saveEntity(MessageHiveEntity data) async {
    await saveMessageEntity(data);
  }

  @override
  Future<MessageHiveEntity?> getEntity(String id) async {
    return getMessageEntity(id);
  }
}
