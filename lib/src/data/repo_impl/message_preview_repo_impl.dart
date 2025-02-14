
import 'package:amity_sdk/src/data/converter/message_preview/message_preview_hive_extention_converter.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/data/data_source/local/hive_entity/message_preview_hive_entity.dart';
import 'package:amity_sdk/src/domain/model/message/amity_message_preview.dart';
import 'package:amity_sdk/src/domain/repo/message_preview_repo.dart';

class MessagePreviewRepoImpl extends MessagePreviewRepo {

  final DbAdapterRepo dbAdapterRepo;

  MessagePreviewRepoImpl({required this.dbAdapterRepo});

  @override
  Future clearAllMessagePreviews() async {
    return await dbAdapterRepo.messagePreviewDbAdapter.clearAllMessagePreviews();
  }

  @override
  Future clearDeletedMessagePreviews() async {
    return await dbAdapterRepo.messagePreviewDbAdapter.clearDeletedMessagePreviews();
  }

  @override
  Future deleteMessagePreview(String messagePreviewId) async {
    return await dbAdapterRepo.messagePreviewDbAdapter.deleteMessagePreview(messagePreviewId);
  }

  @override
  Future<AmityMessagePreview?> getMessagePreview(String messagePreviewId) async {
    final entity = await dbAdapterRepo.messagePreviewDbAdapter.getMessagePreview(messagePreviewId);
    return entity?.convertToAmityMessagePreview();
  }

  @override
  Future<MessagePreviewHiveEntity?> getMessagePreviewByChannelId(String channelId) async {
    return await dbAdapterRepo.messagePreviewDbAdapter.getMessagePreviewByChannelId(channelId);
  }

  @override
  Future<MessagePreviewHiveEntity?> getMessagePreviewBySubChannelId(String subChannelId) async {
    return await dbAdapterRepo.messagePreviewDbAdapter.getMessagePreviewBySubChannelId(subChannelId);
  }

  @override
  Future saveMessagePreview(MessagePreviewHiveEntity messagePreview) async {
    return await dbAdapterRepo.messagePreviewDbAdapter.saveMessagePreview(messagePreview);
  }

  @override
  Future saveMessagePreviews(List<MessagePreviewHiveEntity> messagePreviews) async {
    return await dbAdapterRepo.messagePreviewDbAdapter.saveMessagePreviews(messagePreviews);
  }

  @override
  Future updateSubChannelInfo(String subChannelId, String subChannelName, DateTime subChannelUpdatedAt) async {
    return await dbAdapterRepo.messagePreviewDbAdapter.updateSubChannelInfo(subChannelId, subChannelName, subChannelUpdatedAt);
  }
  
  @override
  Stream<List<MessagePreviewHiveEntity>> listenMessagePreviewEntities() {
    return dbAdapterRepo.messagePreviewDbAdapter.listenMessagePreviews();
  }

}
