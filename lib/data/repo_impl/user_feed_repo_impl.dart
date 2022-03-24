import 'dart:async';

import 'package:amity_sdk/core/model/api_request/get_user_feed_request.dart';
import 'package:amity_sdk/core/utils/tuple.dart';
import 'package:amity_sdk/data/data.dart';
import 'package:amity_sdk/data/data_source/local/db_adapter/feed_paging_db_adapter.dart';
import 'package:amity_sdk/data/data_source/remote/api_interface/user_feed_api_interface.dart';
import 'package:amity_sdk/domain/model/amity_post.dart';
import 'package:amity_sdk/domain/repo/user_feed_repo.dart';

class UserFeedRepoImpl extends UserFeedRepo {
  final UserFeedApiInterface _userFeedApiInterface;
  final PostDbAdapter postDbAdapter;
  final CommentDbAdapter commentDbAdapter;
  final UserDbAdapter userDbAdapter;
  final FileDbAdapter fileDbAdapter;
  final FeedPagingDbAdapter feedDbAdapter;
  UserFeedRepoImpl(
      this._userFeedApiInterface,
      this.postDbAdapter,
      this.commentDbAdapter,
      this.userDbAdapter,
      this.fileDbAdapter,
      this.feedDbAdapter);

  @override
  Future<Tuple2<List<AmityPost>, String>> getUserFeed(
      GetUserFeedRequest request) async {
    final data = await _userFeedApiInterface.getUserFeed(request);

    //Save the feed sequence in to feed db
    await feedDbAdapter.updateFeedCollection(data.convertToFeedHiveEntity());

    final amitPosts = await _saveDataToDb(data);

    return Tuple2(amitPosts, data.paging!.next!);
  }

  @override
  Stream<Tuple2<List<AmityPost>, String>> getUserFeedStream(
      GetUserFeedRequest request) {
    StreamController<Tuple2<List<AmityPost>, String>> controller =
        StreamController<Tuple2<List<AmityPost>, String>>();

    ///1. Get Feed Collection from the DB
    _getUserFeedCollectionFromDb('${request.hashCode}').then((value) {
      if (value != null) {
        controller.add(value);
      }
    }).onError((error, stackTrace) {});

    /// 2. Make the API request and send the updated data back
    getUserFeed(request).then((value) {
      if (value != null) {
        controller.add(value);
      }
    });

    ///3. Listen any chagnes in the Amity Post Db and send the update back
    feedDbAdapter.listenFeedEntity('${request.hashCode}').listen((event) {
      //there is a change in collection, get the collection from the db and add it to stream
      _getUserFeedCollectionFromDb('${request.hashCode}').then((value) {
        if (value != null) {
          controller.add(value);
        }
      });
    });

    return controller.stream;
  }

  Future<Tuple2<List<AmityPost>, String>?> _getUserFeedCollectionFromDb(
      String collectionId) async {
    //Get feed collection from the db
    final data = feedDbAdapter.getFeedEntity(collectionId);

    if (data != null) {
      //Get all the post in feed collection from post db
      final amitPosts = await Stream.fromIterable(data.postIds!)
          .asyncMap((element) async =>
              postDbAdapter.getPostEntity(element).convertToAmityPost())
          .toList();

      //return tuple for token and amitypost list
      return Tuple2(amitPosts, data.nextToken!);
    }

    return Future.value();
  }

  Future<List<AmityPost>> _saveDataToDb(CreatePostResponse data) async {
    //Convert to File Hive Entity
    //we have save the file first, since every object depends on file
    List<FileHiveEntity> fileHiveEntities =
        data.files.map((e) => e.convertToFileHiveEntity()).toList();

    //Convert to User Hive Entity
    List<UserHiveEntity> userHiveEntities =
        data.users.map((e) => e.convertToUserHiveEntity()).toList();

    //Convert to Comment Hive Entity
    List<CommentHiveEntity> commentHiveEntities =
        data.comments.map((e) => e.convertToCommentHiveEntity()).toList();

    //Convert to Post Hive Entity
    List<PostHiveEntity> postChildHiveEntities =
        data.postChildren.map((e) => e.convertToPostHiveEntity()).toList();

    List<PostHiveEntity> postHiveEntities =
        data.posts.map((e) => e.convertToPostHiveEntity()).toList();

    //Save the File Entity
    for (var e in fileHiveEntities) {
      await fileDbAdapter.saveFileEntity(e);
    }

    //Save Child Post Entity
    for (var e in postChildHiveEntities) {
      await postDbAdapter.savePostEntity(e);
    }

    //Save the User Entity
    for (var e in userHiveEntities) {
      await userDbAdapter.saveUserEntity(e);
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
}
