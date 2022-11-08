import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:dio/dio.dart';

/// [ChannelApiInterfaceImpl]
class ChannelApiInterfaceImpl extends ChannelApiInterface {
  /// init [ChannelApiInterfaceImpl]
  ChannelApiInterfaceImpl({required this.httpApiClient});

  /// Http Client
  final HttpApiClient httpApiClient;

  @override
  Future<CreateChannelResponse> createChannel(CreateChannelRequest request) {
    // TODO: implement createChannel
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteChannel(String channelId) {
    // TODO: implement deleteChannel
    throw UnimplementedError();
  }

  @override
  Future<CreateChannelResponse> getChannel(String channelId) async {
    try {
      final data = await httpApiClient().get('$CHANNELS_V3/$channelId');
      return CreateChannelResponse.fromJson(data.data);
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future<CreateChannelResponse> getChannelQuery(
      GetChannelRequest request) async {
    try {
      final data = await httpApiClient()
          .get(CHANNELS_V3, queryParameters: request.toJson());
      return CreateChannelResponse.fromJson(data.data);
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future<CreateChannelResponse> updateChannel(CreateChannelRequest request) {
    throw UnimplementedError();
  }

  @override
  Future muteChannel(UpdateChannelMembersRequest request) async {
    try {
      final data = await httpApiClient()
          .put('$CHANNEL_V2/${request.channelId}/mute', data: request.toJson());
      return;
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }
}
