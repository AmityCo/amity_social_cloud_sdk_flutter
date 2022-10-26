import 'package:hive/hive.dart';

part 'channel_hive_entity_20.g.dart';

/// Data Field for Channel
@HiveType(typeId: 20)
class ChannelHiveEntity extends HiveObject{
  /// Channel Id
  String? channelId;

  /// Is Distinct
  bool? isDistinct;

  /// Metadata
  Map<String, dynamic>? metadata;

  ///type
  String? type;

  /// tags
  List<String>? tags;

  /// is Muted
  bool? isMuted;

  /// Is Rate Limited
  bool? isRateLimited;

  /// DateTimeOut
  DateTime? muteTimeout;

  /// Rate Limit
  int? rateLimit;

  /// Rate Limit Window
  int? rateLimitWindow;

  /// Rate Limit Timeout
  DateTime? rateLimitTimeout;

  ///Display Name
  String? displayName;

  /// Message Auth DeleteEnable
  bool? messageAutoDeleteEnabled;

  /// Auto Delete Message By Flag Limit
  int? autoDeleteMessageByFlagLimit;

  /// Member Count
  int? memberCount;

  /// Message Count
  int? messageCount;

  /// Last Activity
  DateTime? lastActivity;

  /// Create At
  DateTime? createdAt;

  /// Update At
  DateTime? updatedAt;

  /// Avatar File id
  String? avatarFileId;

  /// Is Deleted
  bool? isDeleted;
}
