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
  Future deleteMessagesByChannelId(String channelId) async {
    box.values
        .where((element) => element.channelId == channelId)
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
        .where((element) => element.syncState == AmityMessageSyncState.SYNCING)
        .toList();
  }

  @override
  int getHighestChannelSagment(String channelId) {
    return box.values
        .where((element) =>
            element.channelId == channelId &&
            element.parentId == null &&
            (element.syncState == AmityMessageSyncState.SYNCING ||
                element.syncState == AmityMessageSyncState.SYNCED))
        .fold<int>(
            0,
            (previousValue, element) => element.channelSegment! > previousValue
                ? element.channelSegment!
                : previousValue);
  }
}
