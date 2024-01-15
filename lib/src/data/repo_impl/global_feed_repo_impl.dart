import 'dart:async';

import 'package:amity_sdk/src/core/model/api_request/get_global_feed_request.dart';
import 'package:amity_sdk/src/core/utils/page_list_data.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/model/amity_post.dart';
import 'package:amity_sdk/src/domain/repo/global_feed_repo.dart';

/// Global Feed Repo Impl
class GlobalFeedRepoImpl extends GlobalFeedRepo {
  /// Global Feed Repo Interface
  final GlobalFeedApiInterface feedApiInterface;

  /// Common Db Adapter
  final DbAdapterRepo dbAdapterRepo;

  /// Init Global Feed Repo Impl
  GlobalFeedRepoImpl(
      {required this.feedApiInterface, required this.dbAdapterRepo});

  @override
  Future<PageListData<List<AmityPost>, String>> getGlobalFeed(
      GetGlobalFeedRequest request) async {
    final data = await feedApiInterface.getGlobalFeed(request);

    //Save the feed sequence in to feed db
    await dbAdapterRepo.feedDbAdapter
        .updateFeedCollection(data.convertToFeedHiveEntity());

    // final amitPosts = await dbAdapterRepo.saveDataToDb(data);
    final amitPosts = await data.saveToDb<AmityPost>(dbAdapterRepo);

    return PageListData(amitPosts, data.paging!.next ?? '');
  }

  @override
  Stream<PageListData<List<AmityPost>, String>> getGlobalFeedStream(
      GetGlobalFeedRequest request) {
    StreamController<PageListData<List<AmityPost>, String>> controller =
        StreamController<PageListData<List<AmityPost>, String>>();

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

  Future<PageListData<List<AmityPost>, String>?> _getGlobalFeedCollectionFromDb(
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
  
  @override
  Future<PageListData<List<AmityPost>, String>> getCustomPostRanking(GetGlobalFeedRequest request) async {
    final data = await feedApiInterface.getCustomPostRanking(request);

    //Save the feed sequence in to feed db
    await dbAdapterRepo.feedDbAdapter
        .updateFeedCollection(data.convertToFeedHiveEntity());

    // final amitPosts = await dbAdapterRepo.saveDataToDb(data);
    final amitPosts = await data.saveToDb<AmityPost>(dbAdapterRepo);

    return PageListData(amitPosts, data.paging!.next ?? '');
  }
}
