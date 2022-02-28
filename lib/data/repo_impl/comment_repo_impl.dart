import 'package:amity_sdk/core/model/api_request/create_comment_request.dart';
import 'package:amity_sdk/core/model/api_request/get_comment_request.dart';
import 'package:amity_sdk/data/data.dart';
import 'package:amity_sdk/data/data_source/remote/api_interface/commnet_api_interface.dart';
import 'package:amity_sdk/domain/domain.dart';

class CommentRepoImpl extends CommentRepo {
  final CommentApiInterface commentApiInterface;
  final CommentDbAdapter commentDbAdapter;
  final UserDbAdapter userDbAdapter;
  final FileDbAdapter fileDbAdapter;
  CommentRepoImpl(
      {required this.commentDbAdapter,
      required this.commentApiInterface,
      required this.userDbAdapter,
      required this.fileDbAdapter});
  @override
  Future<AmityComment> getCommentByIdFromDb(String commentId) async {
    final commentHiveEntity =
        await commentDbAdapter.getCommentEntity(commentId);
    return commentHiveEntity.convertToAmityComment();
  }

  @override
  Future<AmityComment> createComment(CreateCommentRequest request) async {
    final data = await commentApiInterface.createComment(request);

    final amityComments = await _saveDetailsToDb(data);

    return Future.value(amityComments[0]);
  }

  @override
  Future<List<AmityComment>> queryComment(GetCommentRequest request) async {
    final data = await commentApiInterface.queryComment(request);

    final amityComments = await _saveDetailsToDb(data);

    return Future.value(amityComments);
  }

  @override
  Future<bool> deleteComment(String commentId) async {
    final data = await commentApiInterface.deleteComment(commentId);
    return data;
  }

  @override
  Future<bool> flagComment(String commentId) async {
    final data = await commentApiInterface.flagComment(commentId);
    return data;
  }

  @override
  Future<AmityComment> getComment(String commentId) async {
    final data = await commentApiInterface.getComment(commentId);

    final amityComments = await _saveDetailsToDb(data);

    return Future.value(amityComments[0]);
  }

  @override
  Future<bool> isCommentFlagByMe(String commentId) async {
    final data = await commentApiInterface.isCommentFlagByMe(commentId);
    return data;
  }

  @override
  Future<bool> unflagComment(String commentId) async {
    final data = await commentApiInterface.unflagComment(commentId);
    return data;
  }

  @override
  Future<AmityComment> updateComment(
      String commentId, CreateCommentRequest request) async {
    final data = await commentApiInterface.updateComment(commentId, request);

    final amityComments = await _saveDetailsToDb(data);

    return Future.value(amityComments[0]);
  }

  Future<List<AmityComment>> _saveDetailsToDb(CreatePostResponse data) async {
    //Convert to Comment Hive Entity
    List<CommentHiveEntity> commentHiveEntities =
        data.comments.map((e) => e.convertToCommentHiveEntity()).toList();

    //Convert to User Hive Entity
    List<UserHiveEntity> userHiveEntities =
        data.users.map((e) => e.convertToUserHiveEntity()).toList();

    //Convert to File Hive Entity
    List<FileHiveEntity> fileHiveEntities =
        data.files.map((e) => e.convertToFileHiveEntity()).toList();

    //Save the Comment Entity
    for (var e in commentHiveEntities) {
      await commentDbAdapter.saveCommentEntity(e);
    }

    //Save the User Entity
    for (var e in userHiveEntities) {
      await userDbAdapter.saveUserEntity(e);
    }

    //Save the File Entity
    for (var e in fileHiveEntities) {
      await fileDbAdapter.saveFileEntity(e);
    }
    return commentHiveEntities.map((e) => e.convertToAmityComment()).toList();
  }
}
