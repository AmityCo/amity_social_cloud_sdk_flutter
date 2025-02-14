import 'package:amity_sdk/src/data/data.dart';

/// [MessageResponse]
class MessageResponse {
  /// init [MessageResponse]
  MessageResponse({
    this.referenceId,
    required this.messageId,
    required this.channelId,
    required this.segment,
    required this.userId,
    this.type,
    required this.data,
    this.channelSegment,
    required this.parentId,
    required this.fileId,
    required this.tags,
    required this.metadata,
    required this.flagCount,
    required this.hashFlag,
    required this.childrenNumber,
    required this.reactionsCount,
    this.reactions,
    required this.myReactions,
    required this.latestReaction,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    this.editedAt,
    required this.mentionees,
    this.subChannelId,
  });

  final String? referenceId;

  /// Message ID
  final String messageId;

  /// Channel ID
  final String channelId;

  final String? subChannelId;

  /// Segment
  final int segment;

  /// User ID
  final String userId;

  /// Type
  String? type;

  /// Message Data
  final MessageDataResponse data;

  /// Channel Segment
  int? channelSegment;

  /// Parent ID
  final String? parentId;

  /// File ID
  final String? fileId;

  /// Tags
  final List<String> tags;

  /// Metadata
  final Map<String, dynamic>? metadata;

  /// Flag Count
  final int flagCount;

  /// Hash Flag
  final HashFlag? hashFlag;

  /// Childer number
  final int childrenNumber;

  /// Reactions count
  final int reactionsCount;

  /// Reactions
  Map<String, int>? reactions;

  /// My Reaction
  List<String>? myReactions;

  /// Latest Reaction
  Map<String, dynamic>? latestReaction;

  /// Is Deleted
  final bool isDeleted;

  /// Created At
  final DateTime createdAt;

  /// Updated At
  final DateTime updatedAt;

  /// Edited At
  DateTime? editedAt;

  /// Mentions
  final List<Mentionee> mentionees;

  /// [MessageResponse]
  factory MessageResponse.fromJson(Map<String, dynamic> json) =>
      MessageResponse(
        referenceId: json["referenceId"],
        messageId: json["messageId"],
        channelId: json["channelId"],
        segment: json["segment"],
        subChannelId: json["messageFeedId"],
        userId: json["creatorPublicId"] ?? json["userId"],
        type: json["dataType"],
        data: MessageDataResponse.fromJson(json["data"]),
        channelSegment: json["segment"],
        parentId: json["parentId"],
        fileId: json["fileId"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        metadata: json["metadata"],
        flagCount: json["flagCount"],
        hashFlag: json["hashFlag"] == null
            ? null
            : HashFlag.fromJson(json["hashFlag"]),
        childrenNumber: json["childrenNumber"] ?? 0,
        reactionsCount: json["reactionsCount"] ?? 0,
        reactions: json["reactions"] != null ? Map.from(json["reactions"]) : null,
        myReactions: json["myReactions"] == null
            ? null
            : List<String>.from(json["myReactions"].map((x) => x)),
        latestReaction: json["latestReaction"],
        isDeleted: json["isDeleted"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        editedAt: json["editedAt"] != null ? DateTime.parse(json["editedAt"]) : null,
        mentionees: json["mentionees"] != null
            ? List<Mentionee>.from(json["mentionees"].map((x) => Mentionee.fromJson(x)))
            : [],
      );

  /// Convert [MessageResponse] to Map
  Map<String, dynamic> toJson() => {
        "referenceId": referenceId,
        "messageId": messageId,
        "channelId": channelId,
        "segment": segment,
        "userId": userId,
        "dataType": type,
        "data": data.toJson(),
        "segment": channelSegment,
        "parentId": parentId,
        "fileId": fileId,
        "messageFeedId": subChannelId,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "metadata": metadata,
        "flagCount": flagCount,
        "hashFlag": hashFlag?.toJson(),
        "childrenNumber": childrenNumber,
        "reactionsCount": reactionsCount,
        "reactions": reactions,
        "myReactions": myReactions == null
            ? null
            : List<dynamic>.from(myReactions!.map((x) => x)),
        "latestReaction": latestReaction,
        "isDeleted": isDeleted,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "editedAt": editedAt?.toIso8601String(),
        "mentionees": List<dynamic>.from(mentionees.map((x) => x.toJson())),
      };

  MessageResponse copyWith({
    String? referenceId,
    String? messageId,
    String? channelId,
    int? segment,
    String? userId,
    String? type,
    MessageDataResponse? data,
    int? channelSegment,
    String? parentId,
    String? fileId,
    List<String>? tags,
    Map<String, dynamic>? metadata,
    int? flagCount,
    HashFlag? hashFlag,
    int? childrenNumber,
    int? reactionsCount,
    Map<String, int>? reactions,
    List<String>? myReactions,
    Map<String, dynamic>? latestReaction,
    bool? isDeleted,
    DateTime? createdAt,
    String? subChannelId,
    DateTime? updatedAt,
    DateTime? editedAt,
    List<Mentionee>? mentionees,
  }) {
    return MessageResponse(
      referenceId: referenceId ?? this.referenceId,
      messageId: messageId ?? this.messageId,
      channelId: channelId ?? this.channelId,
      segment: segment ?? this.segment,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      data: data ?? this.data,
      subChannelId: subChannelId ?? this.subChannelId,
      channelSegment: channelSegment ?? this.channelSegment,
      parentId: parentId ?? this.parentId,
      fileId: fileId ?? this.fileId,
      tags: tags ?? this.tags,
      metadata: metadata ?? this.metadata,
      flagCount: flagCount ?? this.flagCount,
      hashFlag: hashFlag ?? this.hashFlag,
      childrenNumber: childrenNumber ?? this.childrenNumber,
      reactionsCount: reactionsCount ?? this.reactionsCount,
      reactions: reactions ?? this.reactions,
      myReactions: myReactions ?? this.myReactions,
      latestReaction: latestReaction ?? this.latestReaction,
      isDeleted: isDeleted ?? this.isDeleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      editedAt: editedAt ?? this.editedAt,
      mentionees: mentionees ?? this.mentionees,
    );
  }
}

/// [LatestReaction]
class LatestReaction {
  /// Init [LatestReaction]
  LatestReaction({
    required this.referenceId,
    required this.referenceType,
    required this.reactionName,
    required this.userId,
    required this.userDisplayName,
    required this.reactionId,
    required this.eventName,
    required this.createdAt,
  });

  /// Reference Id
  final String referenceId;

  /// Reference Type
  final String referenceType;

  /// Reaction Name
  final String reactionName;

  /// User Id
  final String userId;

  /// User Display Name
  final String userDisplayName;

  /// Reactio Id
  final String reactionId;

  /// Event Name
  final String eventName;

  /// Created At
  final DateTime createdAt;

  factory LatestReaction.fromJson(Map<String, dynamic> json) => LatestReaction(
        referenceId: json["referenceId"],
        referenceType: json["referenceType"],
        reactionName: json["reactionName"],
        userId: json["userId"],
        userDisplayName: json["userDisplayName"],
        reactionId: json["reactionId"],
        eventName: json["eventName"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "referenceId": referenceId,
        "referenceType": referenceType,
        "reactionName": reactionName,
        "userId": userId,
        "userDisplayName": userDisplayName,
        "reactionId": reactionId,
        "eventName": eventName,
        "createdAt": createdAt.toIso8601String(),
      };
}

/// Mentionee
class Mentionee {
  /// init [Mentionee]
  Mentionee({
    required this.type,
    required this.userIds,
  });

  /// Mentionee type
  final String type;

  /// Ids
  final List<String>? userIds;

  factory Mentionee.fromJson(Map<String, dynamic> json) => Mentionee(
        type: json["type"],
        userIds: json["userIds"] == null
            ? null
            : List<String>.from(json["userIds"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "userIds": List<dynamic>.from((userIds ?? []).map((x) => x)),
      };
}

// class _HashFlag {
//   _HashFlag({
//     required this.bits,
//     required this.hashes,
//     required this.hash,
//   });

//   final int bits;
//   final int hashes;
//   final String hash;

//   factory _HashFlag.fromJson(Map<String, dynamic> json) => _HashFlag(
//         bits: json["bits"],
//         hashes: json["hashes"],
//         hash: json["hash"],
//       );

//   Map<String, dynamic> toJson() => {
//         "bits": bits,
//         "hashes": hashes,
//         "hash": hash,
//       };
// }

class Data {
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data();

  Map<String, dynamic> toJson() => {};
}
