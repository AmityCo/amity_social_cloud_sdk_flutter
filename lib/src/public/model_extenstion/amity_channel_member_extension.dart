import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

extension AmityChannelMemberExtension on AmityChannelMember {
  Future muteMembers({Duration timeout = const Duration(minutes: 10)}) {
    return serviceLocator<ChannelMemberMuteUsecase>().get(
      UpdateChannelMembersRequest(
        channelId: channelId!,
        userIds: [userId!],
        mutePeriod: timeout.inMilliseconds,
      ),
    );
  }
}
