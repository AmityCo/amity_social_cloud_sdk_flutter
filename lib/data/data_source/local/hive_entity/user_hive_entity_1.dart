import 'package:hive/hive.dart';

part 'user_hive_entity.g.dart';

@HiveType(typeId: 1)
class UserHiveEntity extends HiveObject {
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
}
