import 'package:amity_sdk/src/core/core.dart';
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
}
