import 'dart:async';
import 'dart:collection';
import 'dart:math';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/utils/amity_nonce.dart';
import 'package:amity_sdk/src/data/data_source/data_source.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/domain/repo/paging_id_repo.dart';
import 'package:collection/collection.dart';

class CommunityMemberObserveNewItemUsecase
    extends ObserverUseCase<PagingIdHiveEntity, GetCommunityMembersRequest> {
  final CommunityMemberRepo repo;
  final PagingIdRepo pagingIdRepo;
  final CommunityMemberComposerUsecase composerUsecase;

  CommunityMemberObserveNewItemUsecase(
      {required this.repo,
      required this.pagingIdRepo,
      required this.composerUsecase});

  @override
  StreamController<PagingIdHiveEntity> listen(
      RequestBuilder<GetCommunityMembersRequest> request) {
    final streamController = StreamController<PagingIdHiveEntity>();
    HashMap<String, bool> syncedIdMap = HashMap();

    repo.listenCommunityMembers(request).listen((event) async {
      _onChanges(syncedIdMap, streamController, request);
    });

    return streamController;
  }

  void _onChanges(
    HashMap<String, bool> syncedIdMap,
    StreamController streamController,
    RequestBuilder<GetCommunityMembersRequest> request,
  ) {
    final hash = request().getHashCode();
    final nonce = request().getNonce().value;
    

    var firstPosition = 0;
    if (streamController.isClosed ||
        (request().keyword != null &&
        request().keyword!.isNotEmpty)) {
      return;
    }

    final communityMemberEntities = repo.getComunityMemberEntities(request);
    final pagingIds = pagingIdRepo.getPagingIdEntities(nonce, hash);

    if (pagingIds.isNotEmpty) {
      firstPosition = pagingIds.map((e) => e.position ?? 0).reduce(min);
    }

    if (communityMemberEntities.isNotEmpty) {
      final syncedIds = pagingIds.map((e) => e.id).toList();
      final unsyncEntities = communityMemberEntities
          .where(
              (member) => member.id != null && !syncedIds.contains(member.id))
          .toList();

      // If keyword is not null or empty, we don't need to observe new item.
      // It will add the wrong entity to the paging data since
      // the keyword is the part of User link object and it cannot be in the predicate
      // of getComunityMemberEntities query.
      unsyncEntities.forEachIndexed((index, member) {
        final unsyncId = member.id;
        if (unsyncId != null && !syncedIdMap.containsKey(unsyncId)) {
          final pagingId = PagingIdHiveEntity(
            id: unsyncId,
            hash: hash,
            nonce: nonce,
            position: firstPosition - (index + 1),
          );
          if (!streamController.isClosed) {
            syncedIdMap[unsyncId] = true;
            streamController.add(pagingId);
          }
        }
      });
    }
  }
}
