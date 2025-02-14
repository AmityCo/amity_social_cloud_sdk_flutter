// ignore_for_file: unused_local_variable

import 'dart:async';
import 'dart:math';

import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/utils/amity_nonce.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/domain/repo/paging_id_repo.dart';
import 'package:collection/collection.dart';

/// [ChannelRepoImpl]
class ChannelRepoImpl extends ChannelRepo {
  /// Channel API Interface
  final ChannelApiInterface channelApiInterface;

  ///Db Adapter
  final DbAdapterRepo commonDbAdapter;

  final PagingIdRepo pagingIdRepo;

  /// init [ChannelRepoImpl]
  ChannelRepoImpl({
    required this.channelApiInterface,
    required this.commonDbAdapter,
    required this.pagingIdRepo,
  });

  @override
  Future<AmityChannel> createChannel(CreateChannelRequest request) async {
    final data = await (request.type == AmityChannelType.CONVERSATION.value
        ? channelApiInterface.createConversationChannel(request)
        : channelApiInterface.createChannel(request));
    final amityChannel = await data.saveToDb<AmityChannel>(commonDbAdapter);
    return amityChannel.first;
  }

  @override
  Future<AmityChannel> updateChannel(CreateChannelRequest request) async {
    final data = await channelApiInterface.updateChannel(request);
    final amityChannel = await data.saveToDb<AmityChannel>(commonDbAdapter);
    return amityChannel.first;
  }

  @override
  Future<AmityChannel> getChannelById(String channelId) async {
    return commonDbAdapter.channelDbAdapter
        .getEntity(channelId)
        .convertToAmityChannel();
  }

  @override
  Future deleteChannel(String channelId) async {
    final data = await channelApiInterface.deleteChannel(channelId);

    ///Get the post from DB and update the delete flag to true
    final amityChannelDb =
        commonDbAdapter.channelDbAdapter.getEntity(channelId);
    amityChannelDb
      ..isDeleted = true
      ..save();

    return data;
  }

  @override
  Future<AmityChannel> getChannel(String channelId) async {
    final data = await channelApiInterface.getChannel(channelId);
    final amityChannel = await data.saveToDb<AmityChannel>(commonDbAdapter);
    return amityChannel.first;
  }

  @override
  Future<PageListData<List<AmityChannel>, String>> getChannelQuery(
      GetChannelRequest request) async {
    final hash = request.getHashCode();
    final nonce = request.getNonce();
    int nextIndex = 0;
    final isFirstPage = request.options?.token == null && (request.options?.limit ?? 0) > 0;
    final data = await channelApiInterface.getChannelQuery(request);
    final amityChannel = await data.saveToDb<AmityChannel>(commonDbAdapter);
    if (isFirstPage) {
      await pagingIdRepo.deletePagingIdByHash(nonce.value, hash);
    } else {
      nextIndex = (pagingIdRepo.getPagingIdEntities(nonce.value, hash).map((e) => (e.position ?? 0)).toList().reduce(max)) + 1;
    }
    data.channels.forEachIndexed((index, element) async {
      final pagingId = PagingIdHiveEntity(
        id: element.channelId,
        hash: hash,
        nonce: nonce.value,
        position: nextIndex + index,
      );
      await pagingIdRepo.savePagingId(pagingId);
    });
    return PageListData(amityChannel, data.paging?.next ?? '');
  }

  @override
  Future muteChannel(UpdateChannelMembersRequest request) async {
    final data = await channelApiInterface.muteChannel(request);

    final amityChannelEntity =
        commonDbAdapter.channelDbAdapter.getEntity(request.channelId);

    if (request.mutePeriod! > 0) {
      amityChannelEntity.isMuted = true;
    } else if (request.mutePeriod! == 0) {
      amityChannelEntity.isMuted = false;
    }

    await amityChannelEntity.save();
  }

  @override
  Stream<List<AmityChannel>> listenChannels(
      RequestBuilder<GetChannelRequest> request) {
    final channels = commonDbAdapter.channelDbAdapter.listenChannelEntities(request);
    return channels.map((event) => event.map((e) => e.convertToAmityChannel()).toList());
  }

  @override
  List<ChannelHiveEntity> getChannelEntities(
      RequestBuilder<GetChannelRequest> request) {
    return commonDbAdapter.channelDbAdapter.getChannelEntities(request);
  }

  @override
  ChannelHiveEntity? getChannelEntity(String channelId) {
    try {
      return commonDbAdapter.channelDbAdapter.getEntity(channelId);
    } catch (e) {
      return null;
    }
  }

  @override
  Future saveChannelEntity(ChannelHiveEntity data) async {
    await commonDbAdapter.channelDbAdapter.saveEntity(data);
  }

  @override
  bool hasInLocal(String channelId) {
    ChannelHiveEntity? channel;
    try {
      channel = commonDbAdapter.channelDbAdapter.getEntity(channelId);
    } catch (e) {
      // When fail to get channel from cache let the channel be null
    }
    return channel != null;
  }

  @override
  Future<List<AmityChannel>> getChannels(List<String> channelIds) async {
    final data = await channelApiInterface.getChannels(channelIds);
    final amityChannel = await data.saveToDb<AmityChannel>(commonDbAdapter);
    return amityChannel;
  }

  @override
  Future<String?> getMessagePreviewId(String channelId) async {
    final messgePreview = await commonDbAdapter.messagePreviewDbAdapter.getMessagePreviewByChannelId(channelId);
    return messgePreview?.messagePreviewId;
  }
}
