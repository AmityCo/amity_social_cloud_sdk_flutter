import 'package:amity_sdk/amity_sdk.dart';

class AmityMessagePreview {
  final String messagePreviewId;
  final AmityMessageDataType dataType;
  final AmityMessageData data;
  final Map<String, dynamic>? rawData;
  final String channelId;
  final String subChannelId;
  String subChannelName;
  final String userId;
  AmityUser? user;
  final bool isDeleted;
  final int segment;
  final DateTime createdAt;
  final DateTime updatedAt;

  AmityMessagePreview({
    required this.messagePreviewId,
    required this.dataType,
    required this.data,
    this.rawData,
    required this.channelId,
    required this.subChannelId,
    required this.subChannelName,
    required this.userId,
    this.user,
    required this.isDeleted,
    required this.segment,
    required this.createdAt,
    required this.updatedAt,
  });
}