import 'dart:async';
import 'dart:collection';
import 'dart:math';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/utils/amity_nonce.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/domain/repo/paging_id_repo.dart';
import 'package:collection/collection.dart';

class FollowingObserveNewItemUsecase
    extends ObserverUseCase<PagingIdHiveEntity, FollowRequest> {
  final UserRepo userRepo;
  final FollowRepo followRepo;
  final PagingIdRepo pagingIdRepo;
  HashMap<String, bool> uniqueIdMap = HashMap();

  FollowingObserveNewItemUsecase(
      {required this.userRepo,
      required this.followRepo,
      required this.pagingIdRepo});

  @override
  StreamController<PagingIdHiveEntity> listen(
      RequestBuilder<FollowRequest> request) {
    final streamController = StreamController<PagingIdHiveEntity>();
    final hash = request().getHashCode();
    final nonce = request().getFollowingNonce().value;
    pagingIdRepo.listenPagingIdEntities(nonce, hash).listen((event) async {
      _onChanges(streamController, request);
    });
    followRepo.listenFollowings(request).listen((event) async {
      _onChanges(streamController, request);
    });
    userRepo.listenUserEntities().listen((event) async {
      _onChanges(streamController, request);
    });
    return streamController;
  }

  void _onChanges(
    StreamController streamController,
    RequestBuilder<FollowRequest> request,
  ) {
    final hash = request().getHashCode();
    final nonce = request().getFollowingNonce().value;
    var firstPosition = 0;
    if (streamController.isClosed) {
      return;
    }
    final followEntities = followRepo.getFollowEntities(request);
    final pagingIds = pagingIdRepo.getPagingIdEntities(nonce, hash);
    if (pagingIds.isNotEmpty) {
      firstPosition = pagingIds.map((e) => e.position ?? 0).reduce(min);
    }
    if (followEntities.isNotEmpty) {
      final uniqueIds = pagingIds.map((e) => e.id).toList();
      final unsyncEntities = followEntities
          .where((follow) => !uniqueIds.contains(follow.id))
          .toList();
      unsyncEntities.sort((a, b) => (a.createdAt ?? DateTime.now())
          .compareTo((b.createdAt ?? DateTime.now())));
      unsyncEntities.forEachIndexed((index, follow) {
        final uniqueId = follow.id;
        if (uniqueId != null) {
          final pagingId = PagingIdHiveEntity(
            id: uniqueId,
            hash: hash,
            nonce: nonce,
            position: firstPosition - (index + 1),
          );
          if (!streamController.isClosed) {
            uniqueIdMap[uniqueId] = true;
            streamController.add(pagingId);
          }
        }
      });
    }
  }
}
