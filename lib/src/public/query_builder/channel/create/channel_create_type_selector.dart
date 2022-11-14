import 'package:amity_sdk/src/public/public.dart';

class ChannelCreatorTypeSelection {
  CommunityChannelCreator communityType() {
    return CommunityChannelCreator();
  }

  LiveChannelCreator liveType() {
    return LiveChannelCreator();
  }

  ConversationChannelCreator conversationType() {
    return ConversationChannelCreator();
  }
}
