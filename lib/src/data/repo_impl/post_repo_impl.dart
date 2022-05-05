import 'dart:async';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class PostRepoImpl extends PostRepo {
  final PublicPostApiInterface publicPostApiInterface;
  final PostDbAdapter postDbAdapter;
  final CommentDbAdapter commentDbAdapter;
  final UserDbAdapter userDbAdapter;
  final FileDbAdapter fileDbAdapter;
  final CommunityDbAdapter communityDbAdapter;
  PostRepoImpl(
      {required this.publicPostApiInterface,
      required this.postDbAdapter,
      required this.commentDbAdapter,
      required this.userDbAdapter,
      required this.fileDbAdapter,
      required this.communityDbAdapter});

  @override
  Future<AmityPost> getPostById(String postId) async {
    //0. Get the data from local DB , change it to Amity Post and Emit it(converter extension)
    //1. Get the data from remote data source - PostEntity
    //2. Change the remote data source data PostEntity to PostHiveEntiry(converter extension)
    //3. Save the PostHiveEntity to local db(hive client)
    //4. Change this PostHiveentity to AmityPost and emit it again

    //Get the data from remote source and return it
    final data = await publicPostApiInterface.getPostById(postId);

    final amitPosts = await _saveDataToDb(data);

    return amitPosts[0];
  }

  @override
  Future<AmityPost> createPost(CreatePostRequest request) async {
    final data = await publicPostApiInterface.createPost(request);
    final amitPosts = await _saveDataToDb(data);
    return amitPosts[0];
  }

  @override
  Future<AmityPost> getPostByIdFromDb(String id) async {
    return postDbAdapter.getPostEntity(id).convertToAmityPost();
  }

  @override
  Future<bool> deletePostById(String postId) async {
    final data = await publicPostApiInterface.deletePostById(postId);

    ///Get the post from DB and update the delete flag to true
    final amityPostDb = postDbAdapter.getPostEntity(postId);
    amityPostDb
      ..isDeleted = true
      ..save();

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
  Future<AmityPost> updatePostById(UpdatePostRequest request) async {
    final data = await publicPostApiInterface.updatePostById(request);
    final amitPosts = await _saveDataToDb(data);
    return amitPosts[0];
  }

  @override
  Future<Tuple2<List<AmityPost>, String>> queryPost(
      GetPostRequest request) async {
    final data = await publicPostApiInterface.queryPost(request);
    final amitPosts = await _saveDataToDb(data);
    return Tuple2(amitPosts, data.paging!.next ?? '');
  }

  Future<List<AmityPost>> _saveDataToDb(CreatePostResponse data) async {
    //Convert to File Hive Entity
    //we have save the file first, since every object depends on file
    List<FileHiveEntity> fileHiveEntities =
        data.files.map((e) => e.convertToFileHiveEntity()).toList();

    //Convert to Community Hive Entity
    List<CommunityHiveEntity> communityHiveEntities =
        data.communities.map((e) => e.convertToCommunityHiveEntity()).toList();

    //Convert to User Hive Entity
    List<UserHiveEntity> userHiveEntities =
        data.users.map((e) => e.convertToUserHiveEntity()).toList();

    //Convert to Comment Hive Entity
    List<CommentHiveEntity> commentHiveEntities =
        data.comments.map((e) => e.convertToCommentHiveEntity()).toList();

    //Convert Child Post to Post Hive Entity
    List<PostHiveEntity> postChildHiveEntities =
        data.postChildren.map((e) => e.convertToPostHiveEntity()).toList();

    //Conver Post to Post Hive Entity
    List<PostHiveEntity> postHiveEntities =
        data.posts.map((e) => e.convertToPostHiveEntity()).toList();

    //Save the File Entity
    for (var e in fileHiveEntities) {
      await fileDbAdapter.saveFileEntity(e);
    }

    //Save the Community Entity
    for (var e in communityHiveEntities) {
      await communityDbAdapter.saveCommunityEntity(e);
    }

    //Save the User Entity
    for (var e in userHiveEntities) {
      await userDbAdapter.saveUserEntity(e);
    }

    //Save Child Post Entity
    for (var e in postChildHiveEntities) {
      await postDbAdapter.savePostEntity(e);
    }

    //Save the Comment Entity
    for (var e in commentHiveEntities) {
      await commentDbAdapter.saveCommentEntity(e);
    }

    //Save Post Entity
    for (var e in postHiveEntities) {
      await postDbAdapter.savePostEntity(e);
    }

    return postHiveEntities.map((e) => e.convertToAmityPost()).toList();
  }

  @override
  Stream<AmityPost> getPostByIdStream(String postId) {
    StreamController<AmityPost> controller = StreamController<AmityPost>();
    //1. Get Amity Post from local db
    getPostByIdFromDb(postId).then((value) {
      controller.add(value);
    }).onError((error, stackTrace) {});

    // 2. Make the API request and send the updated data back
    getPostById(postId).then((value) {
      controller.add(value);
    });

    //3. Listen any chagnes in the Amity Post Db and send the update back
    postDbAdapter.listenPostEntity(postId).listen((event) {
      controller.add(event.convertToAmityPost());
    });

    //1. Amity Post
    //2. Comment
    //3. User
    //4. File

    return controller.stream;
  }
}
