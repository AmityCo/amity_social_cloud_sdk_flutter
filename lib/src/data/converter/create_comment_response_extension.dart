import 'package:amity_sdk/src/data/data.dart';

/// Create Comment Response Extension
extension CreateCommentResponseExtension on CreateCommentResponse {
  /// extension method to save the create comment response to db
  Future saveToDb<T>(DbAdapterRepo dbRepo) async {
    //Convert to File Hive Entity
    List<FileHiveEntity> fileHiveEntities = files.map((e) => e.convertToFileHiveEntity()).toList();

    //Convert to User Hive Entity
    List<UserHiveEntity> userHiveEntities = users.map((e) => e.convertToUserHiveEntity()).toList();

    //Convert to Child Comment Hive Entity
    List<CommentHiveEntity> childCommentHiveEntities =
        commentChildren.map((e) => e.convertToCommentHiveEntity()).toList();

    //Convert to Comment Hive Entity
    List<CommentHiveEntity> commentHiveEntities = comments.map((e) => e.convertToCommentHiveEntity()).toList();

    //Save the File Entity
    for (var e in fileHiveEntities) {
      await dbRepo.fileDbAdapter.saveFileEntity(e);
    }

    //Save the User Entity
    for (var e in userHiveEntities) {
      await dbRepo.userDbAdapter.saveUserEntity(e);
    }

    //Save the Child Comment Entity
    for (var e in childCommentHiveEntities) {
      await dbRepo.commentDbAdapter.saveCommentEntity(e);
    }

    //Save the Comment Entity
    for (var e in commentHiveEntities) {
      await dbRepo.commentDbAdapter.saveCommentEntity(e);
    }

    // FIXME: right logic for type checking
    if (T.toString() == 'AmityComment') {
      return commentHiveEntities.map((e) => e.convertToAmityComment()).toList();
    }
  }
}
