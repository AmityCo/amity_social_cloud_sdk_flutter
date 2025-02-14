import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/data/data_source/local/db_adapter/message_preview_db_adapter.dart';
import 'package:amity_sdk/src/data/data_source/local/hive_entity/message_preview_hive_entity.dart';
import 'package:hive/hive.dart';

/// MessageDbAdapterImpl
class MessagePreviewDbAdapterImpl extends MessagePreviewDbAdapter {

  MessagePreviewDbAdapterImpl({required this.dbClient});

  /// Db Client
  final DBClient dbClient;

  /// Message Box
  late Box<MessagePreviewHiveEntity> box;
  Future<MessagePreviewDbAdapter> init() async {
    Hive.registerAdapter(MessagePreviewHiveEntityAdapter(), override: true);
    box = await Hive.openBox<MessagePreviewHiveEntity>('message_preview_db');
    return this;
  }
  
  @override
  Future clearAllMessagePreviews() async {
    await box.clear();
  }
  
  @override
  Future clearDeletedMessagePreviews() async {
    final keysToDelete = box.keys.where((key) {
      final messagePreview = box.get(key);
      return messagePreview?.isDeleted ?? false;
    }).toList();
    await box.deleteAll(keysToDelete);
  }
  
  @override
  Future deleteMessagePreview(String messagePreviewId) async {
    await box.delete(messagePreviewId);
  }
  
  @override
  Future<MessagePreviewHiveEntity?> getMessagePreview(String messagePreviewId) async {
    return box.get(messagePreviewId);
  }
  
  @override
  Future<MessagePreviewHiveEntity?> getMessagePreviewByChannelId(String channelId) async {
    var previews = box.values.cast<MessagePreviewHiveEntity?>().where(
      (messagePreview) => messagePreview?.channelId == channelId,
    ).toList();
    previews.sort((a, b) => b!.createdAt!.compareTo(a!.createdAt!));
    if (previews.isNotEmpty) {
      return previews.first;
    } else {
      return null;
    }
  }
  
  @override
  Future<MessagePreviewHiveEntity?> getMessagePreviewBySubChannelId(String subChannelId) async {
    return box.values.cast<MessagePreviewHiveEntity?>().firstWhere(
      (messagePreview) => messagePreview?.subChannelId == subChannelId,
      orElse: () => null,
    );
  }
  
  @override
  Future saveMessagePreview(MessagePreviewHiveEntity messagePreview) async {
    return await box.put(messagePreview.messagePreviewId, messagePreview);
  }
  
  @override
  Future saveMessagePreviews(List<MessagePreviewHiveEntity> messagePreviews) async {
    final Map<String, MessagePreviewHiveEntity> messagePreviewMap = {
      for (var messagePreview in messagePreviews) messagePreview.messagePreviewId!: messagePreview
    };
    await box.putAll(messagePreviewMap);
  }
  
  @override
  Future updateSubChannelInfo(String subChannelId, String subChannelName, DateTime subChannelUpdatedAt) async {
    final messagePreviews = box.values.where((messagePreview) => messagePreview.subChannelId == subChannelId);
    for (var messagePreview in messagePreviews) {
      messagePreview.subChannelName = subChannelName;
      messagePreview.subChannelUpdatedAt = subChannelUpdatedAt;
      await box.put(messagePreview.messagePreviewId!, messagePreview);
    }
  }
  
  @override
  Stream<List<MessagePreviewHiveEntity>> listenMessagePreviews() {
    return box.watch().map((event) => box.values.toList());
  }
}
