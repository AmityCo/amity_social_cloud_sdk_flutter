import 'dart:async';

import 'package:amity_sdk/core/model/api_request/get_global_feed_request.dart';
import 'package:amity_sdk/core/utils/tuple.dart';
import 'package:amity_sdk/data/data.dart';
import 'package:amity_sdk/data/data_source/local/db_adapter_repo.dart';
import 'package:amity_sdk/domain/model/amity_post.dart';
import 'package:amity_sdk/domain/repo/global_feed_repo.dart';

class GlobalFeedRepoImpl extends GlobalFeedRepo {
  final GlobalFeedApiInterface feedApiInterface;

  final DbAdapterRepo dbAdapterRepo;
  GlobalFeedRepoImpl(
      {required this.feedApiInterface, required this.dbAdapterRepo});

  @override
  Future<Tuple2<List<AmityPost>, String>> getGlobalFeed(
      GetGlobalFeedRequest request) async {
    final data = await feedApiInterface.getGlobalFeed(request);

    //Save the feed sequence in to feed db
    await dbAdapterRepo.feedDbAdapter
        .updateFeedCollection(data.convertToFeedHiveEntity());

    final amitPosts = await _saveDataToDb(data);

    return Tuple2(amitPosts, data.paging!.next!);
  }

  @override
  Stream<Tuple2<List<AmityPost>, String>> getGlobalFeedStream(
      GetGlobalFeedRequest request) {
    StreamController<Tuple2<List<AmityPost>, String>> controller =
        StreamController<Tuple2<List<AmityPost>, String>>();

    ///1. Get Feed Collection from the DB
    _getGlobalFeedCollectionFromDb('${request.hashCode}').then((value) {
      if (value != null) {
        controller.add(value);
      }
    }).onError((error, stackTrace) {});

    /// 2. Make the API request and send the updated data back
    getGlobalFeed(request).then((value) {
      controller.add(value);
    });

    ///3. Listen any chagnes in the Amity Post Db and send the update back
    dbAdapterRepo.feedDbAdapter
        .listenFeedEntity('${request.hashCode}')
        .listen((event) {
      //there is a change in collection, get the collection from the db and add it to stream
      _getGlobalFeedCollectionFromDb('${request.hashCode}').then((value) {
        if (value != null) {
          controller.add(value);
        }
      });
    });

    return controller.stream;
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
      await dbAdapterRepo.fileDbAdapter.saveFileEntity(e);
    }

    //Save the Community Entity
    for (var e in communityHiveEntities) {
      await dbAdapterRepo.communityDbAdapter.saveCommunityEntity(e);
    }

    //Save Child Post Entity
    for (var e in postChildHiveEntities) {
      await dbAdapterRepo.postDbAdapter.savePostEntity(e);
    }

    //Save the User Entity
    for (var e in userHiveEntities) {
      await dbAdapterRepo.userDbAdapter.saveUserEntity(e);
    }

    //Save the Comment Entity
    for (var e in commentHiveEntities) {
      await dbAdapterRepo.commentDbAdapter.saveCommentEntity(e);
    }

    //Save Post Entity
    for (var e in postHiveEntities) {
      await dbAdapterRepo.postDbAdapter.savePostEntity(e);
    }

    return postHiveEntities.map((e) => e.convertToAmityPost()).toList();
  }

  Future<Tuple2<List<AmityPost>, String>?> _getGlobalFeedCollectionFromDb(
      String collectionId) async {
    //Get feed collection from the db
    final data = dbAdapterRepo.feedDbAdapter.getFeedEntity(collectionId);

    if (data != null) {
      //Get all the post in feed collection from post db
      final amitPosts = await Stream.fromIterable(data.postIds!)
          .asyncMap((element) async => dbAdapterRepo.postDbAdapter
              .getPostEntity(element)
              .convertToAmityPost())
          .toList();

      //return tuple for token and amitypost list
      return Tuple2(amitPosts, data.nextToken!);
    }

    return Future.value();
  }
}
