import 'package:amity_sdk/src/core/utils/amity_hive_type.dart';
import 'package:hive/hive.dart';

part 'account_hive_entity_0.g.dart';

@HiveType(typeId: AmityHiveType.account)
class AccountHiveEntity extends HiveObject {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? userId;
  @HiveField(2)
  List<String>? roles;
  @HiveField(3)
  List<String>? permissions;
  @HiveField(4)
  String? displayName;
  @HiveField(5)
  String? description;
  @HiveField(6)
  String? avatarFileId;
  @HiveField(7)
  String? avatarCustomUrl;
  @HiveField(8)
  int? flagCount;
  //  HashFlag hashFlag;
  @HiveField(9)
  Map<String, dynamic>? metadata;
  @HiveField(10)
  bool? isGlobalBan;
  @HiveField(11)
  DateTime? createdAt;
  @HiveField(12)
  DateTime? updatedAt;

  @HiveField(13)
  String? deviceId;
  @HiveField(14)
  bool? isActive;
  @HiveField(15)
  String? refreshToken;
  @HiveField(16)
  String? accessToken;
  @HiveField(17)
  String? lastInactiveChannelIdsQuery;
  @HiveField(18)
  DateTime? issuedAt;
  @HiveField(19)
  DateTime? expiresAt;
  @HiveField(20)
  DateTime? aboutToExpireAt;

  AccountHiveEntity({
    this.id,
    this.userId,
    this.roles,
    this.permissions,
    this.displayName,
    this.description,
    this.avatarFileId,
    this.avatarCustomUrl,
    this.flagCount,
    this.metadata,
    this.isGlobalBan,
    this.createdAt,
    this.updatedAt,
    this.deviceId,
    this.isActive,
    this.refreshToken,
    this.accessToken,
    this.lastInactiveChannelIdsQuery,
    this.issuedAt,
    this.expiresAt,
    this.aboutToExpireAt,
  });
}
