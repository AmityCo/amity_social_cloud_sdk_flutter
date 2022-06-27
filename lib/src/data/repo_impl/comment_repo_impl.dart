import 'package:amity_sdk/src/core/model/api_request/create_comment_request.dart';
import 'package:amity_sdk/src/core/model/api_request/get_comment_request.dart';
import 'package:amity_sdk/src/core/model/api_request/update_comment_request.dart';
import 'package:amity_sdk/src/core/utils/page_list_data.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class CommentRepoImpl extends CommentRepo {
  final CommentApiInterface commentApiInterface;
  final CommentDbAdapter commentDbAdapter;
  final UserDbAdapter userDbAdapter;
  final FileDbAdapter fileDbAdapter;
  final PostDbAdapter postDbAdapter;
  CommentRepoImpl(
      {required this.postDbAdapter,
      required this.commentDbAdapter,
      required this.commentApiInterface,
      required this.userDbAdapter,
      required this.fileDbAdapter});

  @override
  Future<AmityComment> getCommentByIdFromDb(String commentId) async {
    final commentHiveEntity = commentDbAdapter.getCommentEntity(commentId);
    return commentHiveEntity.convertToAmityComment();
  }

  @override
  Future<AmityComment> createComment(CreateCommentRequest request) async {
    final data = await commentApiInterface.createComment(request);

    final amityComments = await _saveDetailsToDb(data);

    //Update the post entity, comment Id and comment count
    postDbAdapter.updateComment(
        request.referenceId, amityComments[0].commentId!);

    // Check if comment have any parent comment
    // if yes update the parent comment child count
    if (request.parentId != null) {
      commentDbAdapter.updateChildComment(
          amityComments[0].parentId!, amityComments[0].commentId!);
    }

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

    final amityCommentEntity = commentDbAdapter.getCommentEntity(commentId);

    amityCommentEntity
      ..isDeleted = true
      ..save();

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
      String commentId, UpdateCommentRequest request) async {
    final data = await commentApiInterface.updateComment(commentId, request);

    final amityComments = await _saveDetailsToDb(data);

    return Future.value(amityComments[0]);
  }

  Future<List<AmityComment>> _saveDetailsToDb(
      CreateCommentResponse data) async {
    //Convert to File Hive Entity
    List<FileHiveEntity> fileHiveEntities =
        data.files.map((e) => e.convertToFileHiveEntity()).toList();

    //Convert to User Hive Entity
    List<UserHiveEntity> userHiveEntities =
        data.users.map((e) => e.convertToUserHiveEntity()).toList();

    //Convert to Child Comment Hive Entity
    List<CommentHiveEntity> childCommentHiveEntities = data.commentChildren
        .map((e) => e.convertToCommentHiveEntity())
        .toList();

    //Convert to Comment Hive Entity
    List<CommentHiveEntity> commentHiveEntities =
        data.comments.map((e) => e.convertToCommentHiveEntity()).toList();

    //Save the File Entity
    for (var e in fileHiveEntities) {
      await fileDbAdapter.saveFileEntity(e);
    }

    //Save the User Entity
    for (var e in userHiveEntities) {
      await userDbAdapter.saveUserEntity(e);
    }

    //Save the Child Comment Entity
    for (var e in childCommentHiveEntities) {
      await commentDbAdapter.saveCommentEntity(e);
    }

    //Save the Comment Entity
    for (var e in commentHiveEntities) {
      await commentDbAdapter.saveCommentEntity(e);
    }

    return commentHiveEntities.map((e) => e.convertToAmityComment()).toList();
  }

  @override
  Future<PageListData<List<AmityComment>, String>> queryCommentPagingData(
      GetCommentRequest request) async {
    final data = await commentApiInterface.queryComment(request);

    final amityComments = await _saveDetailsToDb(data);

    return PageListData(amityComments, data.paging!.next ?? '');
  }
}
