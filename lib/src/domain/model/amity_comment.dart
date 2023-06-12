import 'dart:async';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// [AmityComment]
class AmityComment {
  /// init [AmityComment]
  AmityComment({required this.commentId});

  /// Commend ID
  String? commentId;

  /// Reference Type
  AmityCommentReferenceType? referenceType; //TODO: should be enum
  /// Reference ID
  String? referenceId;

  /// User ID
  String? userId;

  /// Parent ID
  String? parentId;

  /// Root ID
  String? rootId;

  /// Data Type
  AmityDataType? dataType;

  /// Data Types
  List<String>? dataTypes;

  /// Comment Data
  AmityCommentData? data;

  /// Child Number
  int? childrenNumber;

  /// Replies ID
  List<String>? repliesId;

  /// Latest Replies
  List<AmityComment>? latestReplies; //composer
  /// Flag Count
  int? flagCount;

  /// My Reactions
  List<String>? myReactions;

  /// Reaction Count
  int? reactionCount;

  /// Reactions
  AmityReactionMap? reactions; //composer
  /// Meta Data
  Map<String, dynamic>? metadata;

  /// Is Deleted
  bool? isDeleted;

  ///Create At
  DateTime? createdAt;

  /// Edited At
  DateTime? editedAt;

  /// Updated At
  DateTime? updatedAt;

  /// Sync State
  String? syncState;

  /// Mentionees
  List<AmityMentionee>? mentionees; //composer
  /// User
  AmityUser? user; //composer
  /// Path
  String? path;

  /// Hash Flag
  Map<String, dynamic>? hashFlag;

  /// Flagged By Me
  bool? flaggedByMe;

  ///Attachements
  List<CommentAttachment>? attachments;

  /// Listen Update in Amity Comment
  StreamController<AmityComment> get listen {
    StreamController<AmityComment> controller = StreamController<AmityComment>();

    serviceLocator<CommentDbAdapter>().listenCommentEntity(commentId!).listen((event) {
      final updateAmityComment = event.convertToAmityComment();

      //TOOD: Good idea would be have compose method inside the object itself
      serviceLocator<CommentComposerUsecase>().get(updateAmityComment).then(
            (value) => controller.add(value),
          );
    });

    return controller;
  }
}

abstract class AmityCommentData {
  final String commentId;
  final String? fileId;
  final Map<String, dynamic>? rawData;
  late AmityFileInfo fileInfo; //Composer, Incase of Text post we dont have fileId, File Info or Raw Data

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

abstract class CommentAttachment {
  CommentAttachment();
  AmityDataType getDataType();
  String getFileId();
}

class CommentImageAttachment extends CommentAttachment {
  final String _fileId;
  AmityImage? _image;
  CommentImageAttachment({required String fileId, AmityImage? image})
      : _fileId = fileId,
        _image = image;

  @override
  AmityDataType getDataType() => AmityDataType.IMAGE;

  @override
  String getFileId() => _fileId;

  AmityImage? getImage() => _image;

  set image(AmityImage image) => _image = image;
}
