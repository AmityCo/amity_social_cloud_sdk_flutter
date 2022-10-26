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
}
