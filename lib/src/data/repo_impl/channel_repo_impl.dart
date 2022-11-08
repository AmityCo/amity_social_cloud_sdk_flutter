// ignore_for_file: unused_local_variable

import 'dart:async';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// [ChannelRepoImpl]
class ChannelRepoImpl extends ChannelRepo {
  /// Channel API Interface
  final ChannelApiInterface channelApiInterface;

  ///Db Adapter
  final DbAdapterRepo commonDbAdapter;

  /// init [ChannelRepoImpl]
  ChannelRepoImpl({
    required this.channelApiInterface,
    required this.commonDbAdapter,
  });

  @override
  Future<AmityChannel> createChannel(CreateChannelRequest request) async {
    final data = await channelApiInterface.createChannel(request);
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
  Future<AmityChannel> updateChannel(CreateChannelRequest request) async {
    final data = await channelApiInterface.updateChannel(request);
    final amityChannel = await data.saveToDb<AmityChannel>(commonDbAdapter);
    return amityChannel.first;
  }

  @override
  Future<PageListData<List<AmityChannel>, String>> getChannelQuery(
      GetChannelRequest request) async {
    final data = await channelApiInterface.getChannelQuery(request);
    final amityChannel = await data.saveToDb<AmityChannel>(commonDbAdapter);
    return PageListData(amityChannel, data.paging?.next ?? '');
  }

  @override
  Future muteChannel(UpdateChannelMembersRequest request) async {
    final data = await channelApiInterface.muteChannel(request);

    final amityChannelEntity =
        commonDbAdapter.channelDbAdapter.getEntity(request.channelId);
    amityChannelEntity.isMuted = true;
    await amityChannelEntity.save();
  }
}
