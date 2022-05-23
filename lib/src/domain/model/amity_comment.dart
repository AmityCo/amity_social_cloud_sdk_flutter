import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/converter/comment_response_hive_entity_extension_converter.dart';
import 'package:amity_sdk/src/data/data_source/local/db_adapter/comment_db_adapter.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:flutter/foundation.dart';

class AmityComment extends ChangeNotifier
    implements ValueListenable<AmityComment> {
  AmityComment({required this.commentId}) {
    serviceLocator<CommentDbAdapter>()
        .listenCommentEntity(commentId!)
        .listen((event) {
      final _updateAmityComment = event.convertToAmityComment();

      //TOOD: Good idea would be have compose method inside the object itself
      serviceLocator<CommentComposerUsecase>().get(_updateAmityComment).then(
            (value) => apply(value),
          );
    });
  }

  String? commentId;
  AmityCommentReferenceType? referenceType; //TODO: should be enum
  String? referenceId;
  String? userId;
  String? parentId;
  String? rootId;
  AmityDataType? dataType;
  AmityCommentData? data;
  int? childrenNumber;
  List<String>? repliesId;
  List<AmityComment>? latestReplies; //composer
  int? flagCount;
  List<String>? myReactions;
  int? reactionCount;
  AmityReactionMap? reactions; //composer
  Map<String, dynamic>? metadata;
  bool? isDeleted;
  DateTime? createdAt;
  DateTime? editedAt;
  DateTime? updatedAt;
  String? syncState;
  List<AmityMentionee>? mentionees; //composer
  AmityUser? user; //composer
  String? path;

  void apply(AmityComment amityComment) {
    //reaction update
    myReactions = amityComment.myReactions;
    reactionCount = amityComment.reactionCount;
    reactions = amityComment.reactions;

    //flag
    flagCount = amityComment.flagCount;

    //Delete
    isDeleted = amityComment.isDeleted;

    //data
    data = amityComment.data;

    //metadata
    metadata = amityComment.metadata;

    //updatedAt
    updatedAt = amityComment.updatedAt;

    //Update the child update
    childrenNumber = amityComment.childrenNumber;
    repliesId = amityComment.repliesId;
    latestReplies = amityComment.latestReplies;

    notifyListeners();
  }

  @override
  String toString() {
    return 'AmityComment(commentId: $commentId, referenceType: $referenceType, referenceId: $referenceId, userId: $userId, parentId: $parentId, rootId: $rootId, dataType: $dataType, data: $data, childrenNumber: $childrenNumber, repliesId: $repliesId, latestReplies: $latestReplies, flagCount: $flagCount, myReactions: $myReactions, reactionCount: $reactionCount, reactions: $reactions, isDeleted: $isDeleted, createdAt: $createdAt, editedAt: $editedAt, updatedAt: $updatedAt, syncState: $syncState, mentionees: $mentionees, user: $user, path: $path)';
  }

  @override
  get value => this;
}

abstract class AmityCommentData {
  final String commentId;
  final String? fileId;
  final Map<String, dynamic>? rawData;
  late AmityFileInfo
      fileInfo; //Composer, Incase of Text post we dont have fileId, File Info or Raw Data

  AmityCommentData({required this.commentId, this.fileId, this.rawData});

  @override
  String toString() => 'AmityCommentData()';
}

class CommentTextData extends AmityCommentData {
  String? text;
  CommentTextData({
    required String commentId,
    this.text,
  }) : super(commentId: commentId);

  @override
  String toString() => 'TextData(commentId: $commentId, text: $text)';
}

class CommentImageData extends AmityCommentData {
  late AmityImage image; //composer
  CommentImageData({
    required String commentId,
    String? fileId,
    Map<String, dynamic>? rawData,
  }) : super(commentId: commentId, fileId: fileId, rawData: rawData);

  @override
  String toString() {
    return 'ImageData(commentId: $commentId, fileId: $fileId, rawData: $rawData, image: $image)';
  }
}

class CommentFileData extends AmityCommentData {
  late AmityFile file; //composer
  CommentFileData({
    required String commentId,
    String? fileId,
    Map<String, dynamic>? rawData,
  }) : super(commentId: commentId, fileId: fileId, rawData: rawData);
}

class CommentVideoData extends AmityCommentData {
  //FIXME: - some vidoe post dont have thubnail, we have to keep thubnail nullable instead of late.
  AmityImage? thumbnail; //composer
  CommentVideoData({
    required String commentId,
    String? fileId,
    Map<String, dynamic>? rawData,
  }) : super(
          commentId: commentId,
          fileId: fileId,
          rawData: rawData,
        );
}

class CommentLiveStreamData extends AmityCommentData {
  String? streamId;
  CommentLiveStreamData({
    required String commentId,
    required this.streamId,
    Map<String, dynamic>? rawData,
  }) : super(commentId: commentId, fileId: streamId, rawData: rawData);
}
