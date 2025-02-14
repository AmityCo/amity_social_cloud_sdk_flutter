import 'dart:async';

import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/utils/amity_nonce.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/domain/repo/paging_id_repo.dart';

class PostObserveUseCase
    extends ObserverUseCase<List<AmityPost>, GetPostRequest> {
  final PostRepo postRepo;
  final PagingIdRepo pagingIdRepo;
  final PostComposerUsecase postComposerUsecase;

  PostObserveUseCase({
    required this.postRepo,
    required this.postComposerUsecase,
    required this.pagingIdRepo,
  });

  @override
  StreamController<List<AmityPost>> listen(
      RequestBuilder<GetPostRequest> request) {
    final hash = request().getHashCode();
    final nonce = request().getNonce().value;
    final streamController = StreamController<List<AmityPost>>();
    _onChanges(streamController, request);
    postRepo.listenPosts(request).listen((event) async {
      _onChanges(streamController, request);
    });
    pagingIdRepo.listenPagingIdEntities(nonce, hash).listen((event) async {
      _onChanges(streamController, request);
    });

    return streamController;
  }

  void _onChanges(
    StreamController streamController,
    RequestBuilder<GetPostRequest> request,
  ) {
    final hash = request().getHashCode();
    final nonce = request().getNonce().value;
    if (streamController.isClosed) {
      return;
    }
    final entities = postRepo.getPostEntities(request);
    final pagingIds = pagingIdRepo.getPagingIdEntities(nonce, hash);
    if (entities.isEmpty || pagingIds.isEmpty) {
      streamController.add(<AmityPost>[]);
    } else {
      final ids = pagingIds.map((e) => e.id).toList();
      final posts = entities
          .where((entity) => ids.contains(entity.postId))
          .map((e) => e.convertToAmityPost())
          .toList()
        ..sort((a, b) {
          if (request().sortBy == AmityPostSortOption.FIRST_CREATED.apiKey) {
            return (a.createdAt ?? DateTime.now())
                .compareTo(b.createdAt ?? DateTime.now());
          } else {
            return (b.createdAt ?? DateTime.now())
                .compareTo(a.createdAt ?? DateTime.now());
          }
        });

      Stream.fromIterable(posts)
          .asyncMap((element) =>
            postComposerUsecase.get(element)
          )
          .toList()
          .then((list) {
            if (!streamController.isClosed) {
              streamController.add(list);
            }
          });
    }
  }
}
