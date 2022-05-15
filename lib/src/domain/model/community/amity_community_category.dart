import 'package:amity_sdk/src/domain/domain.dart';

class AmityCommunityCategory {
  String? categoryId;
  String? name;
  String? avatarId;
  AmityImage? avatar; //Composer
  Map<String, dynamic>? metadata;
  bool? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;
}
