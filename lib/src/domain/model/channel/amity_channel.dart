import 'dart:async';

import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/domain/model/message/amity_message_preview.dart';

/// Amity Channel
class AmityChannel {
  /// Channel ID
  String? channelId;

  /// SubChannel ID
  String? defaultSubChannelId;

  /// Display Name
  String? displayName;

  /// Meta data
  Map<String, dynamic>? metadata;

  /// Message Count
  int? messageCount;

  /// Is Rate Limited
  bool? isRateLimited = false;

  /// Is Muted
  bool? isMuted = false;

  /// Last Activity
  DateTime? lastActivity;

  /// Member Count
  int? memberCount;

  /// Tags
  AmityTags? tags;

  /// Unread Count
  int? unreadCount;

  /// Channel Type
  AmityChannelType amityChannelType = AmityChannelType.COMMUNITY;

  /// Avatar File id
  String? avatarFileId;

  /// Avatar
  AmityImage? avatar; //Compose

  /// Is Deleted
  bool? isDeleted = false;

  /// Hast Mention
  bool? hasMention = false;

  /// Created At
  DateTime? createdAt;

  /// Updated At
  DateTime? updatedAt;

  AmityMessagePreview? messagePreview;

  StreamController<AmityChannel> get listen {
    StreamController<AmityChannel> controller =
        StreamController<AmityChannel>();

    serviceLocator<ChannelDbAdapter>().listenEntity(channelId!).listen((event) {
      final updateAmityChannel = event.convertToAmityChannel();

      //TOOD: Good idea would be have compose method inside the object itself
      serviceLocator<ChannelComposerUsecase>().get(updateAmityChannel).then(
            (value) => controller.add(value),
          );
    });

    return controller;
  }
}
