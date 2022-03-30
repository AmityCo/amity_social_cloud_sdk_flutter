import 'dart:async';

import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/domain/domain.dart';

class GetGlobalFeedUsecase
    extends UseCase<Tuple2<List<AmityPost>, String>, GetGlobalFeedRequest> {
  final GlobalFeedRepo _feedRepo;
  final PostComposerUsecase _postComposerUsecase;
  GetGlobalFeedUsecase(this._feedRepo, this._postComposerUsecase);

  @override
  Future<Tuple2<List<AmityPost>, String>> get(
      GetGlobalFeedRequest params) async {
    final amityPost = await _feedRepo.getGlobalFeed(params);
    final amityComposedPost = await Stream.fromIterable(amityPost.item1)
        .asyncMap((event) => _postComposerUsecase.get(event))
        .toList();
    return amityPost.withItem1(amityComposedPost);
  }

  @override
  Stream<Tuple2<List<AmityPost>, String>> listen(GetGlobalFeedRequest params) {
    //1. Listen to Global Feed collection
    //2. Compose Global Feed Collection post
    StreamController<Tuple2<List<AmityPost>, String>> controller =
        StreamController<Tuple2<List<AmityPost>, String>>();

    _feedRepo.getGlobalFeedStream(params).listen((event) async {
      final amityComposedPost = await Stream.fromIterable(event.item1)
          .asyncMap((event) => _postComposerUsecase.get(event))
          .toList();
      controller.add(event.withItem1(amityComposedPost));
    });

    return controller.stream;
  }
}
