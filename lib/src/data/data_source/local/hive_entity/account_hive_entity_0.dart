import 'package:hive/hive.dart';

part 'account_hive_entity.g.dart';

@HiveType(typeId: 0)
class AccountHiveEntity extends HiveObject {
  String? id;
  String? userId;
  List<String>? roles;
  List<String>? permissions;
  String? displayName;
  String? description;
  String? avatarFileId;
  String? avatarCustomUrl;
  int? flagCount;
  //  HashFlag hashFlag;
  Map<String, dynamic>? metadata;
  bool? isGlobalBan;
  DateTime? createdAt;
  DateTime? updatedAt;

  String? deviceId;
  bool? isActive;
  String? refreshToken;
  String? accessToken;
  String? lastInactiveChannelIdsQuery;
}
