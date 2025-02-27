import 'dart:async';
import 'dart:collection';
import 'dart:math';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/utils/amity_nonce.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/domain/repo/paging_id_repo.dart';
import 'package:collection/collection.dart';

class MessageObserveNewItemUseCase
    extends ObserverUseCase<PagingIdHiveEntity, MessageQueryRequest> {
  /// Message Repo
  final MessageRepo messageRepo;
  final PagingIdRepo pagingIdRepo;

  MessageObserveNewItemUseCase(
      {required this.messageRepo, required this.pagingIdRepo});

  @override
  StreamController<PagingIdHiveEntity> listen(
      RequestBuilder<MessageQueryRequest> request) {
    HashMap<String, bool> uniqueIdMap = HashMap();
    final streamController = StreamController<PagingIdHiveEntity>();
    final hash = request().getHashCode();
    final nonce = request().getNonce().value;
    pagingIdRepo.listenPagingIdEntities(nonce, hash).listen((event) async {
      _onChanges(uniqueIdMap, streamController, request);
    });
    messageRepo.listenMessages(request).listen((event) async {
      _onChanges(uniqueIdMap, streamController, request);
    });
    return streamController;
  }

  void _onChanges(
    HashMap<String, bool> uniqueIdMap,
    StreamController streamController,
    RequestBuilder<MessageQueryRequest> request,
  ) {
    final hash = request().getHashCode();
    final nonce = request().getNonce().value;
    var firstPosition = 0;
    if (streamController.isClosed) {
      return;
    }
    final messageEntities = messageRepo.getMessageEntities(request);
    final pagingIds = pagingIdRepo.getPagingIdEntities(nonce, hash);
    if (pagingIds.isNotEmpty) {
      firstPosition = pagingIds.map((e) => e.position ?? 0).reduce(min);
    }
    if (messageEntities.isNotEmpty) {
      final uniqueIds = pagingIds.map((e) => e.id).toList();
      final unsyncEntities = messageEntities
          .where((message) => !uniqueIds.contains(message.uniqueId))
          .toList();
      unsyncEntities.sort((a, b) => (a.createdAt ?? DateTime.now())
          .compareTo((b.createdAt ?? DateTime.now())));
      unsyncEntities.forEachIndexed((index, message) {
        final uniqueId = message.uniqueId;
        if (uniqueId != null && !uniqueIdMap.containsKey(uniqueId)) {
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
