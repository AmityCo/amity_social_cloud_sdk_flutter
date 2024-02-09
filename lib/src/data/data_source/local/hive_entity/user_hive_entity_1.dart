import 'package:amity_sdk/src/src.dart';
import 'package:hive/hive.dart';

part 'user_hive_entity_1.g.dart';

/// User Hive Entity
@HiveType(typeId: 1)
class UserHiveEntity extends  EkoObject {
  /// User doc Id
  String? id;

  /// USer udid
  String? userId;

  /// User roles incase of the community
  List<String>? roles;

  /// User permisson incase of the community
  List<String>? permissions;

  /// User display name
  String? displayName;

  /// User description
  String? description;

  /// User avatar file id
  String? avatarFileId;

  /// User avatart url (direct Url)
  String? avatarCustomUrl;

  /// User path with networkid 
  String? path;

  /// User flag count
  int? flagCount;
  //  HashFlag hashFlag;
  /// User metadata
  Map<String, dynamic>? metadata;

  /// flag to check if user ban globally
  bool? isGlobalBan;

  /// User Create time
  DateTime? createdAt;

  /// User Update time
  DateTime? updatedAt;

  /// Hash Flag
  Map<String, dynamic>? hashFlag;
  
  @override
  String? getId() {
    return id;
  }
  
  
}
