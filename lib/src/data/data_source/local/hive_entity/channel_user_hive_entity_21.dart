import 'package:hive/hive.dart';

part 'channel_user_hive_entity_21.g.dart';

/// Data Field for Channel
@HiveType(typeId: 21)
class ChannelUserHiveEntity extends HiveObject {
  /// Channel User Id
  String? id;

  /// User Id
  String? userId;

  /// Channel Id
  String? channelId;

  /// Membership
  String? membership;

  /// Is Banned
  bool? isBanned;

  /// Last Activity
  DateTime? lastActivity;

  /// Roles
  List<String>? roles;

  /// Permissions
  List<String>? permissions;

  /// Read to Segment
  int? readToSegment;

  /// Last Mentioned Segment
  int? lastMentionedSegment;

  /// Is Mute
  bool? isMuted;

  /// Mute Timeout
  DateTime? muteTimeout;

  /// Create At
  DateTime? createdAt;

  /// Update At
  DateTime? updatedAt;
}
