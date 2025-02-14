import 'package:amity_sdk/src/data/response/response.dart';

class MessagePreviewResponse {
  final String messagePreviewId;
  final String? dataType;
  final MessageDataResponse? data;
  final String channelId;
  final String subChannelId;
  final String creatorId;
  final bool isDeleted;
  final int segment;
  final DateTime createdAt;
  final DateTime updatedAt;

  MessagePreviewResponse({
    required this.messagePreviewId,
    this.dataType,
    this.data,
    required this.channelId,
    required this.subChannelId,
    required this.creatorId,
    required this.isDeleted,
    required this.segment,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MessagePreviewResponse.fromJson(Map<String, dynamic> json) {
    return MessagePreviewResponse(
      messagePreviewId: json['messageId'],
      dataType: json['dataType'],
      data: json['data'] != null ? MessageDataResponse.fromJson(json['data']) : null,
      channelId: json['channelPublicId'],
      subChannelId: json['messageFeedId'],
      creatorId: json['creatorPublicId'],
      isDeleted: json['isDeleted'],
      segment: json['segment'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'messageId': messagePreviewId,
      'dataType': dataType,
      'data': data,
      'channelPublicId': channelId,
      'messageFeedId': subChannelId,
      'creatorPublicId': creatorId,
      'isDeleted': isDeleted,
      'segment': segment,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}