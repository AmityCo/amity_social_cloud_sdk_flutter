import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/core/enum/amity_comment_reference_type.dart';
import 'package:amity_sdk/domain/domain.dart';

class AmityComment {
  String? commentId;
  AmityCommentReferenceType? referenceType; //TODO: should be enum
  String? referenceId;
  String? userId;
  String? parentId;
  String? rootId;
  AmityDataType? dataType;
  AmityPostData? data;
  int? childrenNumber;
  List<String>? repliesId;
  List<AmityComment>? latestReplies; //composer
  int? flagCount;
  List<String>? myReactions;
  int? reactionCount;
  AmityReactionMap? reactions; //composer
  bool? isDeleted;
  DateTime? createdAt;
  DateTime? editedAt;
  DateTime? updatedAt;
  String? syncState;
  List<AmityMentionee>? mentionees; //composer
  AmityUser? user; //composer
  String? path;

  @override
  String toString() {
    return 'AmityComment(commentId: $commentId, referenceType: $referenceType, referenceId: $referenceId, userId: $userId, parentId: $parentId, rootId: $rootId, dataType: $dataType, data: $data, childrenNumber: $childrenNumber, repliesId: $repliesId, latestReplies: $latestReplies, flagCount: $flagCount, myReactions: $myReactions, reactionCount: $reactionCount, reactions: $reactions, isDeleted: $isDeleted, createdAt: $createdAt, editedAt: $editedAt, updatedAt: $updatedAt, syncState: $syncState, mentionees: $mentionees, user: $user, path: $path)';
  }
}

// enum CommentDataType { TEXT }

// extension DataTypeExtension on CommentDataType {
//   String get value {
//     return CommentDataType.values[index].name.toLowerCase();
//   }

//   CommentDataType enumOf(String value) {
//     return CommentDataType.values.firstWhere(
//       (element) => element.name.toLowerCase() == value.toLowerCase(),
//       orElse: () => CommentDataType.TEXT,
//     );
//   }
// }

// class AmityCommentData {}

// class AmityCommentTextData extends AmityCommentData {
//   String? text;
//   AmityCommentTextData({
//     this.text,
//   });
// }

// enum _State { CREATED, SYNCING, SYNCED, FAILED }

// extension _StateExtension on _State {
//   String get value {
//     return _State.values[index].name.toLowerCase();
//   }

//   _State enumOf(String value) {
//     return _State.values.firstWhere(
//       (element) => element.name.toLowerCase() == value.toLowerCase(),
//       orElse: () => _State.SYNCED,
//     );
//   }
// }
