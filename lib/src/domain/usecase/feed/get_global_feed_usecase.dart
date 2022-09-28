import 'dart:async';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// [GetGlobalFeedUsecase]
class GetGlobalFeedUsecase extends UseCase<
    PageListData<List<AmityPost>, String>, GetGlobalFeedRequest> {
  final GlobalFeedRepo _feedRepo;
  final PostComposerUsecase _postComposerUsecase;

  /// Init [GetGlobalFeedUsecase]
  GetGlobalFeedUsecase(this._feedRepo, this._postComposerUsecase);

  @override
  Future<PageListData<List<AmityPost>, String>> get(
      GetGlobalFeedRequest params) async {
    final amityPost = await _feedRepo.getGlobalFeed(params);
    final amityComposedPost = await Stream.fromIterable(amityPost.data)
        .asyncMap((event) => _postComposerUsecase.get(event))
        .toList();
    return amityPost.withItem1(amityComposedPost);
  }

  /// Listen global feed
  StreamController<PageListData<List<AmityPost>, String>> listen(
      GetGlobalFeedRequest params) {
    //1. Listen to Global Feed collection
    //2. Compose Global Feed Collection post
    StreamController<PageListData<List<AmityPost>, String>> controller =
        StreamController<PageListData<List<AmityPost>, String>>();

    _feedRepo.getGlobalFeedStream(params).listen((event) async {
      final amityComposedPost = await Stream.fromIterable(event.data)
          .asyncMap((event) => _postComposerUsecase.get(event))
          .toList();
      controller.add(event.withItem1(amityComposedPost));
    });

    return controller;
  }
}
