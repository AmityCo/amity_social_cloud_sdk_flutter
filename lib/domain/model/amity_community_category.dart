import 'package:amity_sdk/domain/model/amity_image.dart';

class AmityCommunityCategory {
  String? categoryId;
  String? name;
  AmityImage? avatar;
  Map<String, dynamic>? metadata;
  bool? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;
}
