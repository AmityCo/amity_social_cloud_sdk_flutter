import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// [AmityChannelExtension]
extension AmityChannelExtension on AmityChannel {
  /// Get the member ship for the current users
  Future<AmityChannelMember> getMyMembership() {
    return serviceLocator<ChannelMemberGetUsecase>().get(
        GetChannelMembersRequest(
            channelId: channelId!, memberId: AmityCoreClient.getUserId()));
  }

  /// Add member to channel
  Future addMemebers(List<String> userIds) {
    return serviceLocator<ChannelMemberAddUsecase>().get(
        UpdateChannelMembersRequest(channelId: channelId!, userIds: userIds));
  }

  /// Remove member to channel
  Future removeMemebesr(List<String> userIds) {
    return serviceLocator<ChannelMemberRemoveUsecase>().get(
        UpdateChannelMembersRequest(channelId: channelId!, userIds: userIds));
  }

  /// Get User Roles for the Channel
  Future<List<String>> _getUserRoles(String userId) async {
    AmityChannelMember amityChannelMember =
        await serviceLocator<ChannelMemberGetUsecase>()
            .get(GetChannelMembersRequest(
      channelId: channelId!,
      memberId: userId,
    ));
    return Future.value(amityChannelMember.roles?.roles ?? []);
  }

  /// Get User Permission for the Channel
  Future<List<String>> _getUserPermissions(String userId) async {
    AmityChannelMember amityChannelMember =
        await serviceLocator<ChannelMemberGetUsecase>()
            .get(GetChannelMembersRequest(
      channelId: channelId!,
      memberId: userId,
    ));
    return Future.value(amityChannelMember.permissions?.permissions ?? []);
  }

  /// Get Current logged in User Roles for the Channel
  Future<List<String>> getCurentUserRoles() async {
    return _getUserRoles(AmityCoreClient.getUserId());
  }

  /// Get Current logged in User Roles for the Channel
  Future<List<String>> getCurentUserPermission() async {
    return _getUserPermissions(AmityCoreClient.getUserId());
  }

  /// Mute  channel
  Future muteChannel({Duration timeout = const Duration(minutes: 10)}) {
    return serviceLocator<ChannelMuteUsecase>().get(
      UpdateChannelMembersRequest(
        channelId: channelId!,
        mutePeriod: timeout.inMilliseconds,
      ),
    );
  }
}
