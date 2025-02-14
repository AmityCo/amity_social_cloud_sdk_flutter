import 'dart:async';

import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/utils/amity_nonce.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/domain/repo/message_preview_repo.dart';
import 'package:amity_sdk/src/domain/repo/paging_id_repo.dart';

class ChannelObserveListUseCase
    extends ObserverUseCase<List<AmityChannel>, GetChannelRequest> {
  final ChannelRepo channelRepo;
  final PagingIdRepo pagingIdRepo;
  final ChannelComposerUsecase channelComposerUsecase;
  final MessagePreviewRepo messagePreviewRepo;
  final nonce = AmityNonce.CHANNEL_LIST.value;

  ChannelObserveListUseCase(
      {required this.channelRepo,
      required this.pagingIdRepo,
      required this.channelComposerUsecase,
      required this.messagePreviewRepo});

  @override
  StreamController<List<AmityChannel>> listen(
      RequestBuilder<GetChannelRequest> request) {
    final hash = request().getHashCode();
    final nonce = request().getNonce().value;
    final streamController = StreamController<List<AmityChannel>>();
    channelRepo.listenChannels(request).listen((event) async {
      _onChanges(streamController, request);
    });
    pagingIdRepo.listenPagingIdEntities(nonce, hash).listen((event) async {
      _onChanges(streamController, request);
    });
    messagePreviewRepo.listenMessagePreviewEntities().listen((event) async {
      _onChanges(streamController, request);
    });

    return streamController;
  }

  void _onChanges(
    StreamController streamController,
    RequestBuilder<GetChannelRequest> request,
  ) {
    final hash = request().getHashCode();
    final nonce = request().getNonce().value;
    if (streamController.isClosed) {
      return;
    }
    final channelEntities = channelRepo.getChannelEntities(request);
    final pagingIds = pagingIdRepo.getPagingIdEntities(nonce, hash);
    if (channelEntities.isEmpty || pagingIds.isEmpty) {
      streamController.add(<AmityChannel>[]);
    } else {
      final channelIds = pagingIds.map((e) => e.id).toList();
      final channels = channelEntities
        .where((channel) => channelIds.contains(channel.channelId))
        .map((e) => e.convertToAmityChannel())
        .toList()
        ..sort((a, b) =>
          (b.lastActivity ?? DateTime.now())
            .compareTo(a.lastActivity ?? DateTime.now())
        );
      Stream.fromIterable(channels).forEach((element) async {
        element = await channelComposerUsecase.get(element);
      });
      if (!streamController.isClosed) {
        streamController.add(channels);
      }
    }
  }
}
