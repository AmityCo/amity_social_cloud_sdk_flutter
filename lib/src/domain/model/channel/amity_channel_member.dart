import 'dart:async';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// [AmityChannelMember]
class AmityChannelMember {
  /// Channel ID
  String? channelId;

  /// Channel ID
  String? userId;

  /// Display Name
  String? displayName; // Compose

  /// is Muted
  bool? isMuted = false;

  /// is user banned
  bool? isBanned = false;

  /// user channel roles
  AmityRoles? roles; // Compose

  /// user channel permissions
  AmityPermissions? permissions; // Compose

  /// User
  AmityUser? user; // Compose

  /// Member ship
  AmityMembershipType membership = AmityMembershipType.NONE;

  StreamController<AmityChannelMember> get listen {
    StreamController<AmityChannelMember> controller =
        StreamController<AmityChannelMember>();

    serviceLocator<ChannelUserDbAdapter>()
        .listenEntity('${channelId!}_$userId')
        .listen((event) {
      final updateAmityChannelMember = event.convertToAmityChannelMember();

      //TOOD: Good idea would be have compose method inside the object itself
      serviceLocator<ChannelMemberComposerUsecase>()
          .get(updateAmityChannelMember)
          .then(
            (value) => controller.add(value),
          );
    });

    return controller;
  }
}
