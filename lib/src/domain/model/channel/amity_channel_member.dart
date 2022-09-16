import 'package:amity_sdk/src/domain/domain.dart';

/// [AmityChannelMember]
class AmityChannelMember {
  /// Channel ID
  String? channelId;

  /// Channel ID
  String? userId;

  /// Display Name
  String? displayName;

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
}
