import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/public/public.dart';

/// [AmityChannelParticipation]
class AmityChannelParticipation {
  /// Channel ID
  late String _channelId;

  /// Get member for the channel Id
  AmityChannelParticipation channelId(String id) {
    _channelId = id;
    return this;
  }

  /* begin_public_function 
  id: channel.membership.get_my_membership
  */
  /// Get the member ship for the current users
  Future<AmityChannelMember> getMyMembership() {
    return serviceLocator<ChannelMemberGetUsecase>().get(
        GetChannelMembersRequest(
            channelId: _channelId, memberId: AmityCoreClient.getUserId()));
  }
  /* end_public_function */

  /* begin_public_function 
  id: channel.member.query
  */
  /// Get member for the channel Id
  GetChannelMemberQueryBuilder getMembers() {
    return GetChannelMemberQueryBuilder(serviceLocator(), _channelId);
  }
  /* end_public_function */

  /* begin_public_function 
  id: channel.member.search
  */
  /// Search Member using keyword
  AmityChannelMemberSearch searchMembers(String keyword) {
    return AmityChannelMemberSearch(serviceLocator(), _channelId)
      ..keyword(keyword);
  }
  /* end_public_function */

  // fun startReading() {
  //     return StartReadingChannelParticipationUseCase().execute(channelId)
  // }

  // fun stopReading() {
  //     return StopReadingChannelParticipationUseCase().execute(channelId)
  // }
}
