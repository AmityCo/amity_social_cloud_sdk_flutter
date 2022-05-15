import 'package:hive/hive.dart';

part 'community_category_hive_12.g.dart';

@HiveType(typeId: 12)
class CommunityCategoryHiveEntity {
  String? categoryId;
  String? name;
  String? avatarFileId;
  Map<String, String>? metadata;
  bool? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;
}
