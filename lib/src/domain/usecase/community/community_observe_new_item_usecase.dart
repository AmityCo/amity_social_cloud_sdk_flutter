import 'dart:async';
import 'dart:collection';
import 'dart:math';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/utils/amity_nonce.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/domain/repo/paging_id_repo.dart';
import 'package:collection/collection.dart';

class CommunityObserveNewItemUsecase
    extends ObserverUseCase<PagingIdHiveEntity, GetCommunityRequest> {
  final CommunityRepo communityRepo;
  final PagingIdRepo pagingIdRepo;
  final CommunityComposerUsecase communityComposerUsecase;
  HashMap<String, bool> communityIdMap = HashMap();

  CommunityObserveNewItemUsecase(
      {required this.communityRepo,
      required this.pagingIdRepo,
      required this.communityComposerUsecase});

  @override
  StreamController<PagingIdHiveEntity> listen(
      RequestBuilder<GetCommunityRequest> params) {
    final streamController = StreamController<PagingIdHiveEntity>();

    communityRepo.listenCommunities(params).listen((event) async {
      _onChanges(streamController, params);
    });
    return streamController;
  }

  void _onChanges(
    StreamController streamController,
    RequestBuilder<GetCommunityRequest> request,
  ) {
    final hash = request().getHashCode();
    final nonce = request().getNonce().value;
    var firstPosition = 0;
    if (streamController.isClosed) {
      return;
    }
    final communityEntities = communityRepo.getCommunityEntities(request);
    final pagingIds = pagingIdRepo.getPagingIdEntities(nonce, hash);
    if (pagingIds.isNotEmpty) {
      firstPosition = pagingIds.map((e) => e.position ?? 0).reduce(min);
    }
    if (communityEntities.isNotEmpty && pagingIds.isNotEmpty) {
      final communityIds = pagingIds.map((e) => e.id).toList();
      communityEntities.sort((a, b) {
        var positionA =
            pagingIds.firstWhere((p) => p.id == a.communityId, orElse: () => PagingIdHiveEntity(position: 0)).position ?? 0;
        var positionB =
            pagingIds.firstWhere((p) => p.id == b.communityId, orElse: () => PagingIdHiveEntity(position: 0)).position ?? 0;
        return positionA.compareTo(positionB);
      });

      final communityId = communityEntities
          .where((community) => !communityIds.contains(community.communityId))
          .firstOrNull
          ?.channelId;
      if (communityId != null && communityIdMap[communityId] != true) {
        final pagingId = PagingIdHiveEntity(
          id: communityId,
          hash: hash,
          nonce: nonce,
          position: firstPosition - 1,
        );
        if (!streamController.isClosed) {
          communityIdMap[communityId] = true;
          streamController.add(pagingId);
        }
      }
    }
  }
}
