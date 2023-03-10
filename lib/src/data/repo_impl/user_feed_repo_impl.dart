import 'dart:async';

import 'package:amity_sdk/src/core/model/api_request/get_user_feed_request.dart';
import 'package:amity_sdk/src/core/utils/page_list_data.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/model/amity_post.dart';
import 'package:amity_sdk/src/domain/repo/user_feed_repo.dart';

/// User Feed Repo Impl
class UserFeedRepoImpl extends UserFeedRepo {
  /// User Feed API interface
  final UserFeedApiInterface userFeedApiInterface;

  /// Common Db Adapter
  final DbAdapterRepo dbAdapterRepo;

  /// Init [UserFeedRepoImpl]
  UserFeedRepoImpl({
    required this.userFeedApiInterface,
    required this.dbAdapterRepo,
  });

  @override
  Future<PageListData<List<AmityPost>, String>> getUserFeed(
      GetUserFeedRequest request) async {
    final data = await userFeedApiInterface.getUserFeed(request);

    //Save the feed sequence in to feed db
    await dbAdapterRepo.feedDbAdapter
        .updateFeedCollection(data.convertToFeedHiveEntity());

    final amitPosts = await data.saveToDb<AmityPost>(dbAdapterRepo);

    return PageListData(amitPosts, data.paging!.next ?? '');
  }

  @override
  Stream<PageListData<List<AmityPost>, String>> getUserFeedStream(
      GetUserFeedRequest request) {
    StreamController<PageListData<List<AmityPost>, String>> controller =
        StreamController<PageListData<List<AmityPost>, String>>();

    ///1. Get Feed Collection from the DB
    _getUserFeedCollectionFromDb('${request.hashCode}').then((value) {
      if (value != null) {
        controller.add(value);
      }
    }).onError((error, stackTrace) {});

    /// 2. Make the API request and send the updated data back
    getUserFeed(request).then((value) {
      controller.add(value);
    });

    ///3. Listen any chagnes in the Amity Post Db and send the update back
    dbAdapterRepo.feedDbAdapter
        .listenFeedEntity('${request.hashCode}')
        .listen((event) {
      //there is a change in collection, get the collection from the db and add it to stream
      _getUserFeedCollectionFromDb('${request.hashCode}').then((value) {
        if (value != null) {
          controller.add(value);
        }
      });
    });

    return controller.stream;
  }

  Future<PageListData<List<AmityPost>, String>?> _getUserFeedCollectionFromDb(
      String collectionId) async {
    //Get feed collection from the db
    final data = dbAdapterRepo.feedDbAdapter.getFeedEntity(collectionId);

    if (data != null) {
      //Get all the post in feed collection from post db
      final amitPosts = await Stream.fromIterable(data.postIds!)
          .asyncMap((element) async => dbAdapterRepo.postDbAdapter
              .getPostEntity(element)!
              .convertToAmityPost())
          .toList();

      //return tuple for token and amitypost list
      return PageListData(amitPosts, data.nextToken!);
    }

    return Future.value();
  }
}
