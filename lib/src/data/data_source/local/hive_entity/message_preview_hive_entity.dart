import 'package:amity_sdk/src/core/utils/amity_hive_type.dart';
import 'package:amity_sdk/src/data/data_source/data_source.dart';
import 'package:hive/hive.dart';

part 'message_preview_hive_entity.g.dart';

@HiveType(typeId: AmityHiveType.messagePreview)
class MessagePreviewHiveEntity extends EkoObject {
  @HiveField(0)
  String? messagePreviewId;

  @HiveField(1)
  String? dataType;

  @HiveField(2)
  MessageDataHiveEntity? data;

  @HiveField(3)
  String? channelId;

  @HiveField(4)
  String? subChannelId;

  @HiveField(5)
  String? subChannelName;

  @HiveField(6)
  DateTime? subChannelUpdatedAt;

  @HiveField(7)
  String? creatorId;

  @HiveField(8)
  bool? isDeleted;

  @HiveField(9)
  int? segment;

  @HiveField(10)
  DateTime? createdAt;

  @HiveField(11)
  DateTime? updatedAt;

  MessagePreviewHiveEntity({
    this.messagePreviewId,
    this.dataType,
    this.data,
    this.channelId,
    this.subChannelId,
    this.subChannelName,
    this.subChannelUpdatedAt,
    this.creatorId,
    this.isDeleted,
    this.segment,
    this.createdAt,
    this.updatedAt,
  });

  @override
  String? getId() {
    return messagePreviewId;
  }

  @override
  String toString() {
    return 'MessagePreviewHiveEntity(messagePreviewId: $messagePreviewId, dataType: $dataType, data: $data, channelId: $channelId, subChannelId: $subChannelId, subChannelName: $subChannelName, subChannelUpdatedAt: $subChannelUpdatedAt, creatorId: $creatorId, isDeleted: $isDeleted, segment: $segment, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  MessagePreviewHiveEntity copyWith({
    String? messagePreviewId,
    String? dataType,
    MessageDataHiveEntity? data,
    String? channelId,
    String? subChannelId,
    String? subChannelName,
    DateTime? subChannelUpdatedAt,
    String? creatorId,
    bool? isDeleted,
    int? segment,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MessagePreviewHiveEntity(
      messagePreviewId: messagePreviewId ?? this.messagePreviewId,
      dataType: dataType ?? this.dataType,
      data: data ?? this.data,
      channelId: channelId ?? this.channelId,
      subChannelId: subChannelId ?? this.subChannelId,
      subChannelName: subChannelName ?? this.subChannelName,
      subChannelUpdatedAt: subChannelUpdatedAt ?? this.subChannelUpdatedAt,
      creatorId: creatorId ?? this.creatorId,
      isDeleted: isDeleted ?? this.isDeleted,
      segment: segment ?? this.segment,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}