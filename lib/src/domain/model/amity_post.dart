import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class AmityPost {
  AmityPost({required this.postId});

  String? postId;
  String? mid;
  AmityPostTargetType? targetType;
  AmityPostTarget? target; //composer
  String? parentPostId;
  String? postedUserId;
  String? sharedUserId;
  AmityDataType? type;
  AmityPostData? data; // composer - AmityText,AmityImage,AmityFile,AmityVideo
  Map<String, dynamic>? metadata;
  int? sharedCount;
  bool? flaggedByMe;
  List<String>? myReactions = []; //notifyListeners
  AmityReactionMap? reactions; //notifyListeners
  int? reactionCount; // notifyListeners
  int? commentCount; //notifyListeners
  int? flagCount;
  List<String>? latestCommentIds; //notifyListeners
  List<AmityComment>? latestComments; //composer //notifyListeners
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
  int? reach;
  int? impression;

  Map<String, dynamic>? hashFlag;

  AmityPostAnalytics analytics() {
    return AmityPostAnalytics(mid!);
  }

  @override
  String toString() {
    return 'AmityPost(postId: $postId, parentPostId: $parentPostId, postedUserId: $postedUserId, sharedUserId: $sharedUserId, type: $type, metadata: $metadata, sharedCount: $sharedCount, isFlaggedByMe: $flaggedByMe, myReactions: $myReactions, reactions: $reactions, reactionCount: $reactionCount, commentCount: $commentCount, flagCount: $flagCount, latestCommentIds: $latestCommentIds, latestComments: $latestComments, childrenPostIds: $childrenPostIds, children: $children, postedUser: $postedUser, sharedUser: $sharedUser, isDeleted: $isDeleted, feedType: $feedType, mentionees: $mentionees, createdAt: $createdAt, editedAt: $editedAt, updatedAt: $updatedAt, path: $path, type: $type,data: $data,comment: $latestComments,children: $children)';
  }
}

/// Amity Post Data
abstract class AmityPostData {
  /// Post Id
  final String postId;

  /// File id
  final String? fileId;

  /// Raw Data
  final Map<String, dynamic>? rawData;

  /// File info
  late AmityFileInfo
      fileInfo; //Composer, Incase of Text post we dont have fileId, File Info or Raw Data

  /// Init Amity Post Data
  AmityPostData({required this.postId, this.fileId, this.rawData});

  @override
  String toString() => 'AmityPostData()';
}

/// Text Post Data
class TextData extends AmityPostData {
  /// Text Data
  String? text;

  /// Init Text Data
  TextData({
    required String postId,
    this.text,
  }) : super(postId: postId);

  @override
  String toString() => 'TextData(postId: $postId, text: $text)';
}

/// Image Post Data
class ImageData extends AmityPostData {
  /// Amity Image
  AmityImage? image; //composer

  /// Init Image Data
  ImageData({
    required String postId,
    String? fileId,
    Map<String, dynamic>? rawData,
  }) : super(postId: postId, fileId: fileId, rawData: rawData);

  @override
  String toString() {
    return 'ImageData(postId: $postId, fileId: $fileId, rawData: $rawData, image: $image)';
  }
}

/// File Post dataa
class FileData extends AmityPostData {
  /// Amity File
  late AmityFile? file; //composer

  /// Init File Data
  FileData({
    required String postId,
    String? fileId,
    Map<String, dynamic>? rawData,
  }) : super(postId: postId, fileId: fileId, rawData: rawData);
}

/// Video Post Data
class VideoData extends AmityPostData {
  /// Video Thumbnail
  //FIXME: - some vidoe post dont have thubnail, we have to keep thubnail nullable instead of late.
  AmityImage? thumbnail; //composer

  /// Init Video Data
  VideoData({
    required String postId,
    String? fileId,
    Map<String, dynamic>? rawData,
  }) : super(
          postId: postId,
          fileId: fileId,
          rawData: rawData,
        );
}

/// Live Stream Post Data
class LiveStreamData extends AmityPostData {
  /// Steam Id
  String? streamId;

  /// Init Live Stream Data
  LiveStreamData({
    required String postId,
    required this.streamId,
    Map<String, dynamic>? rawData,
  }) : super(postId: postId, fileId: streamId, rawData: rawData);
}

/// Poll Post Data
class PollData extends AmityPostData {
  /// Poll id
  String pollId;

  /// init Poll Data
  PollData({
    required String postId,
    required this.pollId,
    Map<String, dynamic>? rawData,
  }) : super(postId: postId, rawData: rawData);
}

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
  CommunityTarget({this.targetCommunityId, this.targetCommunity});
  @override
  String toString() =>
      'CommunityTarget(targetCommunityId: $targetCommunityId, targetCommunity: $targetCommunity, postedCommunityMember: $postedCommunityMember)';
}

class UserTarget extends AmityPostTarget {
  String? targetUserId;
  AmityUser? targetUser; //composer
  UserTarget({this.targetUserId, this.targetUser});
  @override
  String toString() =>
      'UserTarget(targetUserId: $targetUserId, targetUser: $targetUser)';
}

class UnknownTarget extends AmityPostTarget {}
