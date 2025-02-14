import 'dart:core';

class SubChannelResponse{

  String? subChannelId;
  String? channelId;
  String? channelPublicId;
  String? networkId;
  String? channelType;
  String? name;
  String? latestMessageId;
  DateTime? lastActivity;
  String? creatorId;
  String? creatorPublicId;
  String? path;   
  String? messagePreviewId;
  int? childCount;
  bool? isDeleted;
  DateTime? editedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  SubChannelResponse({
    this.subChannelId,
    this.channelId,
    this.channelPublicId,
    this.networkId,
    this.channelType,
    this.name,
    this.latestMessageId,
    this.lastActivity,
    this.creatorId,
    this.creatorPublicId,
    this.path,
    this.messagePreviewId,
    this.childCount,
    this.isDeleted,
    this.editedAt,
    this.createdAt,
    this.updatedAt,
  });

  SubChannelResponse.fromJson(Map<String, dynamic> json) {
    subChannelId = json['messageFeedId'];
    channelId = json['channelId'];
    channelPublicId = json['channelPublicId'];
    networkId = json['networkId'];
    channelType = json['channelType'];
    name = json['name'];
    latestMessageId = json['lastMessageId'];
    lastActivity =json['lastMessageTimestamp'] == null ?  null: DateTime.tryParse(json['lastMessageTimestamp']);
    creatorId = json['creatorId'];
    creatorPublicId = json['creatorPublicId'];
    path = json['path'];
    messagePreviewId = json['messagePreviewId']?? null;
    childCount = json['childCount'];
    isDeleted = json['isDeleted'];
    editedAt = json['editedAt'] == null ?  null: DateTime.tryParse(json['editedAt']);
    createdAt = json['createdAt'] == null ?  null: DateTime.tryParse(json['createdAt']);
    updatedAt = json['updatedAt'] == null ?  null: DateTime.tryParse(json['updatedAt']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['messageFeedId'] = subChannelId;
    data['channelId'] = channelId;
    data['channelPublicId'] = channelPublicId;
    data['networkId'] = networkId;
    data['channelType'] = channelType;
    data['name'] = name;
    data['lastMessageId'] = latestMessageId;
    data['lastMessageTimestamp'] = lastActivity;
    data['creatorId'] = creatorId;
    data['creatorPublicId'] = creatorPublicId;
    data['path'] = path;
    data['messagePreviewId'] = messagePreviewId;
    data['childCount'] = childCount;
    data['isDeleted'] = isDeleted;
    data['editedAt'] = editedAt;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}