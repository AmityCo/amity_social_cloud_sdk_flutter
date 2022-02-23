import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/core/enum/reaction_reference_type.dart';
import 'package:amity_sdk/domain/domain.dart';
import 'package:amity_sdk/public/query_builder/reaction/add_reaction_query_builder.dart';

class AmityPost {
  String? postId;
  AmityPostTargetType? targetType;
  AmityPostTarget? target; //composer
  String? parentPostId;
  String? postedUserId;
  String? sharedUserId;
  AmityDataType? type;
  AmityPostData? data; // composer - AmityImage
  Map<String, dynamic>? metadata;
  int? sharedCount;
  bool? isFlaggedByMe;
  List<String>? myReactions = [];
  AmityReactionMap? reactions;
  int? reactionCount;
  int? commentCount;
  int? flagCount;
  List<String>? latestCommentIds;
  List<AmityComment>? latestComments; //composer
  List<String>? childrenPostIds;
  List<AmityPost>? children; //composer
  AmityUser? postedUser; //composer
  AmityUser? sharedUser; //composer
  bool? isDeleted;
  AmityFeedType? feedType;
  List<AmityMentionee>? mentionees; //composer
  DateTime? createdAt;
  DateTime? editedAt;
  DateTime? updatedAt;
  String? path;

  @override
  String toString() {
    return 'AmityPost(postId: $postId, parentPostId: $parentPostId, postedUserId: $postedUserId, sharedUserId: $sharedUserId, type: $type, metadata: $metadata, sharedCount: $sharedCount, isFlaggedByMe: $isFlaggedByMe, myReactions: $myReactions, reactions: $reactions, reactionCount: $reactionCount, commentCount: $commentCount, flagCount: $flagCount, latestCommentIds: $latestCommentIds, latestComments: $latestComments, childrenPostIds: $childrenPostIds, children: $children, postedUser: $postedUser, sharedUser: $sharedUser, isDeleted: $isDeleted, feedType: $feedType, mentionees: $mentionees, createdAt: $createdAt, editedAt: $editedAt, updatedAt: $updatedAt, path: $path, type: $type,data: $data,comment: $latestComments,children: $children)';
  }
}

class AmityPostData {
  @override
  String toString() => 'AmityPostData()';
}

class TextData extends AmityPostData {
  String? postId;
  String? text;
  TextData({
    this.postId,
    this.text,
  });

  @override
  String toString() => 'TextData(postId: $postId, text: $text)';
}

class ImageData extends AmityPostData {
  String? postId;
  String? fileId;
  Map<String, dynamic>? rawData;
  AmityImage? image; //composer
  ImageData({
    this.postId,
    this.fileId,
    this.rawData,
    this.image,
  });

  @override
  String toString() {
    return 'ImageData(postId: $postId, fileId: $fileId, rawData: $rawData, image: $image)';
  }
}

class FileData extends AmityPostData {
  String? postId;
  String? fileId;
  Map<String, dynamic>? rawData;
  AmityImage? file;
}

class VideoData extends AmityPostData {
  String? postId;
  String? fileId;
  Map<String, dynamic>? rawData;
  AmityImage? thumbnail;
  VideoData({
    this.postId,
    this.fileId,
    this.rawData,
    this.thumbnail,
  });
}

class LiveStreamData extends AmityPostData {
  String? postId;
  String? streamId;
  Map<String, dynamic>? rawData;
  LiveStreamData({
    this.postId,
    this.streamId,
    this.rawData,
  });
}

// class PollData extends AmityPostData {
//   String? postId;
//   String? pollId;
//   Map<String, dynamic>? rawData;
//   PollData({
//     this.postId,
//     this.pollId,
//     this.rawData,
//   });
// }

// class CustomData extends AmityPostData {
//   String? postId;
//   String? pollId;
//   Map<String, dynamic>? rawData;
//   CustomData({
//     this.postId,
//     this.pollId,
//     this.rawData,
//   });
// }

class AmityPostTarget {}

class CommunityTarget extends AmityPostTarget {
  String? targetCommunityId;
  AmityCommunity? targetCommunity; //composer
  AmityCommunityMember? postedCommunityMember; //composer

  @override
  String toString() =>
      'CommunityTarget(targetCommunityId: $targetCommunityId, targetCommunity: $targetCommunity, postedCommunityMember: $postedCommunityMember)';
}

class UserTarget extends AmityPostTarget {
  String? targetUserId;
  AmityUser? targetUser; //composer
  UserTarget({
    this.targetUserId,
    this.targetUser,
  });

  @override
  String toString() =>
      'UserTarget(targetUserId: $targetUserId, targetUser: $targetUser)';
}

class UnknownTarget extends AmityPostTarget {}
