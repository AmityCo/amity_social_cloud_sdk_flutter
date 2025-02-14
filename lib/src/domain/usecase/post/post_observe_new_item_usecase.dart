import 'dart:async';
import 'dart:collection';
import 'dart:math';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/utils/amity_nonce.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/domain/repo/paging_id_repo.dart';
import 'package:collection/collection.dart';

class PostObserveNewItemUsecase
    extends ObserverUseCase<PagingIdHiveEntity, GetPostRequest> {
  final PostRepo postRepo;
  final PagingIdRepo pagingIdRepo;
  HashMap<String, bool> entityIdMap = HashMap();

  PostObserveNewItemUsecase(
      {required this.postRepo, required this.pagingIdRepo});

  @override
  StreamController<PagingIdHiveEntity> listen(RequestBuilder<GetPostRequest> request) {
    final streamController = StreamController<PagingIdHiveEntity>();
    final hash = request().getHashCode();
    final nonce = request().getNonce().value;
    pagingIdRepo.listenPagingIdEntities(nonce,hash).listen((event) async {
      _onChanges(streamController, request);
    });
    postRepo.listenPosts(request).listen((event) async {
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
    var firstPosition = 0;
    if (streamController.isClosed) {
      return;
    }
    final entities = postRepo.getPostEntities(request);
    final pagingIds = pagingIdRepo.getPagingIdEntities(nonce, hash);
    if (pagingIds.isNotEmpty){
      firstPosition = pagingIds.map( 
        (e) => e.position ?? 0
      ).reduce(min);
    }
    if (entities.isNotEmpty) {
      final ids = pagingIds.map((e) => e.id).toList();
      final unsyncEntities = entities.where((post) => !ids.contains(post.postId)).toList();
      unsyncEntities.sort((a, b) => (a.createdAt ?? DateTime.now()).compareTo((b.createdAt ?? DateTime.now())));
      unsyncEntities.forEachIndexed((index, post) {
        final entityId = post.postId;
        if (entityId != null && !entityIdMap.containsKey(entityId)) {
          final pagingId = PagingIdHiveEntity(
            id: entityId,
            hash: hash,
            nonce: nonce,
            position: firstPosition - (index + 1),
          );
          if (!streamController.isClosed) {
            entityIdMap[entityId] = true;
            streamController.add(pagingId);
          }
        }
      });
    }
  }
}
