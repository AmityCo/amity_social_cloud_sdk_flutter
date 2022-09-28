import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/public/public.dart';

/// [ChannelParticipationRepository]
class ChannelParticipationRepository {
  /// Channel ID
  late String _channelId;

  /// Get member for the channel Id
  ChannelParticipationRepository channelId(String id) {
    _channelId = id;
    return this;
  }

  /// Get the member ship for the current users
  Future<AmityChannelMember> getMyMembership() {
    return serviceLocator<ChannelMemberGetUsecase>().get(
        GetChannelMembersRequest(
            channelId: _channelId, memberId: AmityCoreClient.getUserId()));
  }

  /// Get member for the channel Id
  GetChannelMemberQueryBuilder getMembers() {
    return GetChannelMemberQueryBuilder(serviceLocator(), _channelId);
  }

  // fun searchMembers(keyword: String): AmityChannelMemberSearch.Builder {
  //     return AmityChannelMemberSearch.Builder(channelId, keyword)
  // }

  // fun addMembers(userIds: List<String>): Single<AmityChannel> {
  //     return AddUsersChannelParticipationUseCase().execute(channelId, userIds)
  // }

  // fun removeMembers(userIds: List<String>): Single<AmityChannel> {
  //     return RemoveUsersChannelParticipationUseCase().execute(channelId, userIds)
  // }

  // fun startReading() {
  //     return StartReadingChannelParticipationUseCase().execute(channelId)
  // }

  // fun stopReading() {
  //     return StopReadingChannelParticipationUseCase().execute(channelId)
  // }

}
