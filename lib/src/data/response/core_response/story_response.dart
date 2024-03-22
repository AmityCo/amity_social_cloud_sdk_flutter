import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/data/response/core_response/story_data_response.dart';
import 'package:amity_sdk/src/domain/model/amity_story_item.dart';

class StoryResponse{
  final String? storyId;
  final String? path;
  final String? creatorId;
  final String? creatorPublicId;

  final String? targetType;
  final String? targetId;
  final String? targetPublicId;
  final String? dataType;
  final List<AmityStoryItem>? items;
  final StoryDataResponse? data;
  final Map<String, dynamic>? metadata;
  final int? flagCount;
  final HashFlag? hashFlag;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? expiresAt;
  final Map<String, int>? reactions;
  final int? reactionsCount;
  final List<String>? myReactions;
  final int? commentsCount;
  final bool? isDeleted;
  final bool? hasFlaggedComment;
  final List<Mentionee>? mentionedUsers;
  final int? impression;
  final int? reach;
  final String? referenceId;

  StoryResponse({
    this.storyId,
    this.path,
    this.creatorId,
    this.creatorPublicId,
    this.targetType,
    this.targetId,
    this.targetPublicId,
    required this.dataType,
    required this.items,
    required this.data,
    this.metadata,
    required this.flagCount,
    this.hashFlag,
    this.createdAt,
    this.updatedAt,
    this.expiresAt,
    this.reactions,
    required this.reactionsCount,
     this.myReactions,
    required this.commentsCount,
    required this.isDeleted,
    required this.hasFlaggedComment,
    required this.mentionedUsers,
    required this.impression,
    required this.reach,
    required this.referenceId,
  });

  factory StoryResponse.fromJson(Map<String, dynamic> json) {
    return StoryResponse(
      storyId: json['storyId'],
      path: json['path'],
      creatorId: json['creatorId'],
      creatorPublicId: json['creatorPublicId'],
      targetType: json['targetType'],
      targetId: json['targetId'],
      targetPublicId: json['targetPublicId'],
      dataType: json['dataType'],
      items: (json['items'] as List).map((e) => AmityStoryItem.fromJson(e)).toList(),
      data: StoryDataResponse.fromJson(json['data']),
      metadata: json['metadata'],
      flagCount: json['flagCount'],
      hashFlag: json['hashFlag'] != null ? HashFlag.fromJson(json['hashFlag']) : null,
      createdAt: json['createdAt'] != null ? DateTime.tryParse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt']) : null,
      expiresAt: json['expiresAt'] != null ? DateTime.tryParse(json['expiresAt']) : null,
      reactions: json['reactions'] != null ? Map<String, int>.from(json['reactions']) : null,
      reactionsCount: json['reactionsCount'],
      myReactions:  json['myReactions'] != null ? List<String>.from(json['myReactions'].map((e) => e) ) : null,
      commentsCount: json['commentsCount'],
      isDeleted: json['isDeleted'],
      hasFlaggedComment: json['hasFlaggedComment'],
      mentionedUsers: (json['mentionedUsers'] as List).map((e) => Mentionee.fromJson(e)).toList(),
      impression: json['impression'],
      reach: json['reach'],
      referenceId: json['referenceId'] ,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['storyId'] = storyId;
    map['path'] = path;
    map['creatorId'] = creatorId;
    map['creatorPublicId'] = creatorPublicId;
    map['targetType'] = targetType;
    map['targetId'] = targetId;
    map['targetPublicId'] = targetPublicId;
    map['dataType'] = dataType;
    map['items'] = items?.map((e) => e.toJson()).toList();
    map['data'] = data?.toJson();
    map['metadata'] = metadata;
    map['flagCount'] = flagCount;
    map['hashFlag'] = hashFlag?.toJson();
    map['createdAt'] = createdAt?.toIso8601String();
    map['updatedAt'] = updatedAt?.toIso8601String();
    map['expiresAt'] = expiresAt?.toIso8601String();
    map['reactions'] = reactions;
    map['reactionsCount'] = reactionsCount;
    map['myReactions'] = myReactions;
    map['commentsCount'] = commentsCount;
    map['isDeleted'] = isDeleted;
    map['hasFlaggedComment'] = hasFlaggedComment;
    map['mentionedUsers'] = mentionedUsers?.map((e) => e.toJson()).toList();
    map['impression'] = impression;
    map['reach'] = reach;
    map['referenceId'] = referenceId;
    return map;
  }
  

}
