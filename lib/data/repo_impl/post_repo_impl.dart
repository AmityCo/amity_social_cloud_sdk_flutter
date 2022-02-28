import 'dart:async';

import 'package:amity_sdk/core/model/api_request/create_post_request.dart';
import 'package:amity_sdk/core/model/api_request/get_post_request.dart';
import 'package:amity_sdk/data/data.dart';
import 'package:amity_sdk/domain/model/amity_post.dart';
import 'package:amity_sdk/domain/repo/post_repo.dart';

class PostRepoImpl extends PostRepo {
  final PublicPostApiInterface publicPostApiInterface;
  final PostDbAdapter postDbAdapter;
  final CommentDbAdapter commentDbAdapter;
  final UserDbAdapter userDbAdapter;
  final FileDbAdapter fileDbAdapter;
  PostRepoImpl(
      {required this.publicPostApiInterface,
      required this.postDbAdapter,
      required this.commentDbAdapter,
      required this.userDbAdapter,
      required this.fileDbAdapter});

  @override
  Future<AmityPost> getPostById(String postId) async {
    //0. Get the data from local DB , change it to Amity Post and Emit it(converter extension)
    //1. Get the data from remote data source - PostEntity
    //2. Change the remote data source data PostEntity to PostHiveEntiry(converter extension)
    //3. Save the PostHiveEntity to local db(hive client)
    //4. Change this PostHiveentity to AmityPost and emit it again

    //Get the data from remote source and return it
    final data = await publicPostApiInterface.getPostById(postId);

    final amitPosts = await _saveDataTpDb(data);

    return amitPosts[0];
  }

  @override
  Future<AmityPost> createPost(CreatePostRequest request) async {
    final data = await publicPostApiInterface.createPost(request);
    return AmityPost();
  }

  @override
  Future<AmityPost> getPostByIdFromDb(String id) {
    return Future.value(postDbAdapter.getPostEntity(id).convertToAmityPost());
  }

  Future<List<AmityPost>> _saveDataTpDb(CreatePostResponse data) async {
    //Convert to Post Hive Entity
    List<PostHiveEntity> postHiveEntities =
        data.posts.map((e) => e.convertToPostHiveEntity()).toList();

    List<PostHiveEntity> postChildHiveEntities =
        data.postChildren.map((e) => e.convertToPostHiveEntity()).toList();

    //Convert to Comment Hive Entity
    List<CommentHiveEntity> commentHiveEntities =
        data.comments.map((e) => e.convertToCommentHiveEntity()).toList();

    //Convert to User Hive Entity
    List<UserHiveEntity> userHiveEntities =
        data.users.map((e) => e.convertToUserHiveEntity()).toList();

    //Convert to File Hive Entity
    List<FileHiveEntity> fileHiveEntities =
        data.files.map((e) => e.convertToFileHiveEntity()).toList();

    //Save Post Entity
    for (var e in postHiveEntities) {
      await postDbAdapter.savePostEntity(e);
    }

    //Save Child Post Entity
    for (var e in postChildHiveEntities) {
      await postDbAdapter.savePostEntity(e);
    }

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

    return postChildHiveEntities.map((e) => e.convertToAmityPost()).toList();
  }

  @override
  Future<bool> deletePostById(String postId) async {
    final data = await publicPostApiInterface.deletePostById(postId);
    return data;
  }

  @override
  Future<bool> flagPost(String postId) async {
    final data = await publicPostApiInterface.flagPost(postId);
    return data;
  }

  @override
  Future<bool> isPostFlagByMe(String postId) async {
    final data = await publicPostApiInterface.isPostFlagByMe(postId);
    return data;
  }

  @override
  Future<bool> unflagPost(String postId) async {
    final data = await publicPostApiInterface.unflagPost(postId);
    return data;
  }

  @override
  Future<AmityPost> updatePostById(
      String postId, CreatePostRequest request) async {
    final data = await publicPostApiInterface.updatePostById(postId, request);
    final amitPosts = await _saveDataTpDb(data);
    return amitPosts[0];
  }

  @override
  Future<List<AmityPost>> queryPost(GetPostRequest request) async {
    final data = await publicPostApiInterface.queryPost(request);
    final amitPosts = await _saveDataTpDb(data);
    return amitPosts;
  }
}
