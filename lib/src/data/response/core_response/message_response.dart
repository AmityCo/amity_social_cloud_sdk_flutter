import 'package:amity_sdk/src/data/data.dart';

/// [MessageResponse]
class MessageResponse {
  /// init [MessageResponse]
  MessageResponse({
    required this.messageId,
    required this.channelId,
    required this.userId,
    required this.type,
    required this.data,
    required this.channelSegment,
    required this.parentId,
    required this.fileId,
    required this.tags,
    required this.metadata,
    required this.flagCount,
    required this.hashFlag,
    required this.childrenNumber,
    required this.reactionsCount,
    required this.reactions,
    required this.myReactions,
    required this.latestReaction,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.editedAt,
    required this.mentionees,
  });

  /// Message ID
  final String messageId;

  /// Channel ID
  final String channelId;

  /// User ID
  final String userId;

  /// Type
  final String type;

  /// Message Data
  final MessageDataResponse data;

  /// Channel Segment
  final int channelSegment;

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
  final _HashFlag? hashFlag;

  /// Childer number
  final int childrenNumber;

  /// Reactions count
  final int reactionsCount;

  /// Reactions
  final Map<String, dynamic> reactions;

  /// My Reaction
  final List<String>? myReactions;

  /// Latest Reaction
  final Map<String, dynamic>? latestReaction;

  /// Is Deleted
  final bool isDeleted;

  /// Created At
  final DateTime createdAt;

  /// Updated At
  final DateTime updatedAt;

  /// Edited At
  final DateTime editedAt;

  /// Mentions
  final List<Mentionee> mentionees;

  /// [MessageResponse]
  factory MessageResponse.fromJson(Map<String, dynamic> json) =>
      MessageResponse(
        messageId: json["messageId"],
        channelId: json["channelId"],
        userId: json["userId"],
        type: json["type"],
        data: MessageDataResponse.fromJson(json["data"]),
        channelSegment: json["channelSegment"],
        parentId: json["parentId"],
        fileId: json["fileId"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        metadata: json["metadata"],
        flagCount: json["flagCount"],
        hashFlag: json["hashFlag"] == null
            ? null
            : _HashFlag.fromJson(json["hashFlag"]),
        childrenNumber: json["childrenNumber"],
        reactionsCount: json["reactionsCount"],
        reactions: json["reactions"],
        myReactions: json["myReactions"] == null
            ? null
            : List<String>.from(json["myReactions"].map((x) => x)),
        latestReaction: json["latestReaction"],
        isDeleted: json["isDeleted"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        editedAt: DateTime.parse(json["editedAt"]),
        mentionees: List<Mentionee>.from(
            json["mentionees"].map((x) => Mentionee.fromJson(x))),
      );

  /// Convert [MessageResponse] to Map
  Map<String, dynamic> toJson() => {
        "messageId": messageId,
        "channelId": channelId,
        "userId": userId,
        "type": type,
        "data": data.toJson(),
        "channelSegment": channelSegment,
        "parentId": parentId,
        "fileId": fileId,
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
        "editedAt": editedAt.toIso8601String(),
        "mentionees": List<dynamic>.from(mentionees.map((x) => x.toJson())),
      };
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

class _HashFlag {
  _HashFlag({
    required this.bits,
    required this.hashes,
    required this.hash,
  });

  final int bits;
  final int hashes;
  final List<int> hash;

  factory _HashFlag.fromJson(Map<String, dynamic> json) => _HashFlag(
        bits: json["bits"],
        hashes: json["hashes"],
        hash: List<int>.from(json["hash"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "bits": bits,
        "hashes": hashes,
        "hash": List<dynamic>.from(hash.map((x) => x)),
      };
}

class Data {
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data();

  Map<String, dynamic> toJson() => {};
}
