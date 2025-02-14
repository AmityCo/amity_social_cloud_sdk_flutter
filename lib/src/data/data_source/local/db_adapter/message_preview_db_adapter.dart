import 'package:amity_sdk/src/data/data_source/local/hive_entity/message_preview_hive_entity.dart';

abstract class MessagePreviewDbAdapter {
    Future<MessagePreviewHiveEntity?> getMessagePreview(String messagePreviewId);

    Future<MessagePreviewHiveEntity?> getMessagePreviewByChannelId(String channelId);

    Future<MessagePreviewHiveEntity?> getMessagePreviewBySubChannelId(String subChannelId);

    Future saveMessagePreviews(List<MessagePreviewHiveEntity> messagePreviews);

    Future saveMessagePreview(MessagePreviewHiveEntity messagePreview);

    Future deleteMessagePreview(String messagePreviewId);

    Future updateSubChannelInfo(String subChannelId, String subChannelName, DateTime subChannelUpdatedAt);

    Future clearDeletedMessagePreviews();

    Future clearAllMessagePreviews();

    Stream<List<MessagePreviewHiveEntity>> listenMessagePreviews();
}
