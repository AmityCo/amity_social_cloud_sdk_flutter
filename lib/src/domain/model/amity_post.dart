import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:flutter/foundation.dart';

class AmityPost extends ChangeNotifier implements ValueListenable<AmityPost> {
  AmityPost({required this.postId}) {
    serviceLocator<PostDbAdapter>().listenPostEntity(postId!).listen((event) {
      final _updateAmityPost = event.convertToAmityPost();

      //TOOD: Good idea would be have compose method inside the object itself
      serviceLocator<PostComposerUsecase>().get(_updateAmityPost).then(
            (value) => apply(value),
          );
    });
  }

  String? postId;
  AmityPostTargetType? targetType;
  AmityPostTarget? target; //composer
  String? parentPostId;
  String? postedUserId;
  String? sharedUserId;
  AmityDataType? type;
  AmityPostData? data; // composer - AmityText,AmityImage,AmityFile,AmityVideo
  Map<String, dynamic>? metadata;
  int? sharedCount;
  bool? isFlaggedByMe;
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

  void apply(AmityPost amityPost) {
    //reaction update
    myReactions = amityPost.myReactions;
    reactionCount = amityPost.reactionCount;
    reactions = amityPost.reactions;

    //flag
    isFlaggedByMe = amityPost.isFlaggedByMe;
    flagCount = amityPost.flagCount;

    //Delete
    isDeleted = amityPost.isDeleted;

    //data
    data = amityPost.data;

    //metadata
    metadata = amityPost.metadata;

    //updatedAt
    updatedAt = amityPost.updatedAt;

    //Comment
    commentCount = amityPost.commentCount;

    notifyListeners();
  }

  @override
  String toString() {
    return 'AmityPost(postId: $postId, parentPostId: $parentPostId, postedUserId: $postedUserId, sharedUserId: $sharedUserId, type: $type, metadata: $metadata, sharedCount: $sharedCount, isFlaggedByMe: $isFlaggedByMe, myReactions: $myReactions, reactions: $reactions, reactionCount: $reactionCount, commentCount: $commentCount, flagCount: $flagCount, latestCommentIds: $latestCommentIds, latestComments: $latestComments, childrenPostIds: $childrenPostIds, children: $children, postedUser: $postedUser, sharedUser: $sharedUser, isDeleted: $isDeleted, feedType: $feedType, mentionees: $mentionees, createdAt: $createdAt, editedAt: $editedAt, updatedAt: $updatedAt, path: $path, type: $type,data: $data,comment: $latestComments,children: $children)';
  }

  @override
  get value => this;
}

abstract class AmityPostData {
  final String postId;
  final String? fileId;
  final Map<String, dynamic>? rawData;
  late AmityFileInfo
      fileInfo; //Composer, Incase of Text post we dont have fileId, File Info or Raw Data

  AmityPostData({required this.postId, this.fileId, this.rawData});

  @override
  String toString() => 'AmityPostData()';
}

class TextData extends AmityPostData {
  String? text;
  TextData({
    required String postId,
    this.text,
  }) : super(postId: postId);

  @override
  String toString() => 'TextData(postId: $postId, text: $text)';
}

class ImageData extends AmityPostData {
  late AmityImage image; //composer
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

class FileData extends AmityPostData {
  late AmityFile file; //composer
  FileData({
    required String postId,
    String? fileId,
    Map<String, dynamic>? rawData,
  }) : super(postId: postId, fileId: fileId, rawData: rawData);
}

class VideoData extends AmityPostData {
  //FIXME: - some vidoe post dont have thubnail, we have to keep thubnail nullable instead of late.
  AmityImage? thumbnail; //composer
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

class LiveStreamData extends AmityPostData {
  String? streamId;
  LiveStreamData({
    required String postId,
    required this.streamId,
    Map<String, dynamic>? rawData,
  }) : super(postId: postId, fileId: streamId, rawData: rawData);
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
