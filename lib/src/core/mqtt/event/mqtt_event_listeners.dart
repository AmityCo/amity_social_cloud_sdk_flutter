import 'package:amity_sdk/src/core/mqtt/event/channel/channel_banned_event_listener.dart';
import 'package:amity_sdk/src/core/mqtt/event/channel/channel_created_event_listener.dart';
import 'package:amity_sdk/src/core/mqtt/event/channel/channel_deleted_event_listener.dart';
import 'package:amity_sdk/src/core/mqtt/event/channel/channel_joined_event_listener.dart';
import 'package:amity_sdk/src/core/mqtt/event/channel/channel_left_event_listener.dart';
import 'package:amity_sdk/src/core/mqtt/event/channel/channel_members_added_event_listener.dart';
import 'package:amity_sdk/src/core/mqtt/event/channel/channel_members_removed_event_listener.dart';
import 'package:amity_sdk/src/core/mqtt/event/channel/channel_unbanned_event_listener.dart';
import 'package:amity_sdk/src/core/mqtt/event/channel/channel_updated_event_listener.dart';
import 'package:amity_sdk/src/core/mqtt/event/event.dart';
import 'package:amity_sdk/src/core/mqtt/event/post/post_approved_event_listener.dart';
import 'package:amity_sdk/src/core/mqtt/event/post/post_declined_event_listener.dart';
import 'package:amity_sdk/src/core/mqtt/event/story/story_create_event_listener.dart';
import 'package:amity_sdk/src/core/mqtt/event/story/story_delete_event_listener.dart';
import 'package:amity_sdk/src/core/mqtt/event/story/story_reaction_added_event_listerner.dart';
import 'package:amity_sdk/src/core/mqtt/event/story/story_reaction_removed_event_listener.dart';
import 'package:amity_sdk/src/core/mqtt/event/stream/stream_flag_event_listener.dart';
import 'package:amity_sdk/src/core/mqtt/event/stream/stream_record_event_listener.dart';
import 'package:amity_sdk/src/core/mqtt/event/stream/stream_start_event_listener.dart';
import 'package:amity_sdk/src/core/mqtt/event/stream/stream_stop_event_listener.dart';
import 'package:amity_sdk/src/core/mqtt/event/stream/stream_terminate_event_listener.dart';
import 'package:amity_sdk/src/core/mqtt/event/subchannel/subchannel_create_event_listener.dart';
import 'package:amity_sdk/src/core/mqtt/event/subchannel/subchannel_delete_event_listener.dart';
import 'package:amity_sdk/src/core/mqtt/event/subchannel/subchannel_update_event_listener.dart';
import 'package:amity_sdk/src/core/mqtt/event/user/user_deleted_event_listener.dart';
import 'package:amity_sdk/src/core/mqtt/event/user/user_flag_cleared_event_listener.dart';
import 'package:amity_sdk/src/core/mqtt/event/user/user_flagged_event_listener.dart';
import 'package:amity_sdk/src/core/mqtt/event/user/user_unflagged_event_listerner.dart';
import 'package:amity_sdk/src/core/mqtt/event/user/user_updated_event_listener.dart';
import 'package:collection/collection.dart' show IterableExtension;

class MqttEventListeners {
  final listeners = List.of([
    ///Post Event
    PostCreateEventListener(),
    PostUpdateEventListener(),
    PostDeleteEventListener(),
    PostAddReactionEventListener(),
    PostRemoveReactionEventListener(),
    PostFlaggedEventListener(),
    PostUnflaggedEventListener(),
    PostApprovedEventListener(),
    PostDeclinedEventListener(),

    ///Comment Event
    CommentCreateEventListener(),
    CommentUpdateEventListener(),
    CommentDeleteEventListener(),
    CommentAddReactionEventListener(),
    CommentRemoveReactionEventListener(),
    CommentFlaggedEventListener(),
    CommentUnflaggedEventListener(),

    ///Community Event
    CommunityCreateEventListener(),
    CommunityUpdateEventListener(),
    CommunityDeleteEventListener(),

    /// Community Member Event
    CommunityJoinEventListener(),
    CommunityLeftEventListener(),
    CommunityUserAddedEventListener(),
    CommunityUserRemovedEventListener(),
    CommunityRoleAddedEventListener(),
    CommunityRoleRemovedEventListener(),
    CommunityUserChangedEventListener(),
    CommunityUserBannedEventListener(),
    CommunityUserUnbannedEventListener(),

    // Stories
    StoryCreateEventListener(),
    StoryDeleteEventListener(),
    StoryReactionAddedEventListener(),
    StoryReactionRemovedEventListener(),

    // SubChannel
    SubChannelCreateEventListener(),
    SubChannelUpdateEventListener(),
    SubChannelDeleteEventListener(),

    //Channel
    ChannelCreatedEventListener(),
    ChannelUpdatedEventListener(),
    ChannelDeletedEventListener(),
    ChannelMembersAddedEventListener(),
    ChannelMembersRemovedEventListener(),
    ChannelBannedEventListener(),
    ChannelUnbannedEventListener(),
    ChannelJoinedEventListener(),
    ChannelLeftEventListener(),

    //Message
    MessageCreatedEventListener(),
    MessageUpdatedEventListener(),
    MessageDeletedEventListener(),
    MessageFlaggedEventListener(),
    MessageUnflaggedEventListener(),
    MessageReactionAddedEventListener(),
    MessageReactionRemovedEventListener(),

    // Users
    UserDeletedEventListener(),
    UserFlagClearedEventListener(),
    UserFlaggedEventListener(),
    UserUnflaggedEventListener(),
    UserUpdatedEventListener(),

    // LiveStream
    StreamStartEventListener(),
    StreamRecordEventListener(),
    StreamStopEventListener(),
    StreamFlagEventListener(),
    StreamTerminateEventListener()
  ]);

  MQTTEventListener? getEvent(String eventType) => listeners
      .firstWhereOrNull((element) => element.getEventName() == eventType);
}
