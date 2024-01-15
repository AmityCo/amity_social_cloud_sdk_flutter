import 'package:amity_sdk/src/src.dart';
import 'package:hive/hive.dart';

part 'community_category_hive_12.g.dart';

@HiveType(typeId: 12)
class CommunityCategoryHiveEntity extends  EkoObject {
  String? categoryId;
  String? name;
  String? avatarFileId;
  Map<String, dynamic>? metadata;
  bool? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;
  
  @override
  String? getId() {
    return categoryId;
  }
}
