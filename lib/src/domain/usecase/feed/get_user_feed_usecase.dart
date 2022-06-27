import 'dart:async';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class GetUserFeedUsecase
    extends UseCase<PageListData<List<AmityPost>, String>, GetUserFeedRequest> {
  final UserFeedRepo _userFeedRepo;
  final PostComposerUsecase _postComposerUsecase;
  GetUserFeedUsecase(this._userFeedRepo, this._postComposerUsecase);

  @override
  Future<PageListData<List<AmityPost>, String>> get(
      GetUserFeedRequest params) async {
    final amityPost = await _userFeedRepo.getUserFeed(params);
    final amityComposedPost = await Stream.fromIterable(amityPost.data)
        .asyncMap((event) => _postComposerUsecase.get(event))
        .toList();
    return amityPost.withItem1(amityComposedPost);
  }

  @override
  Stream<PageListData<List<AmityPost>, String>> listen(
      GetUserFeedRequest params) {
    //1. Listen to Global Feed collection
    //2. Compose Global Feed Collection post
    StreamController<PageListData<List<AmityPost>, String>> controller =
        StreamController<PageListData<List<AmityPost>, String>>();

    _userFeedRepo.getUserFeedStream(params).listen((event) async {
      final amityComposedPost = await Stream.fromIterable(event.data)
          .asyncMap((event) => _postComposerUsecase.get(event))
          .toList();
      controller.add(event.withItem1(amityComposedPost));
    });

    return controller.stream;
  }
}
