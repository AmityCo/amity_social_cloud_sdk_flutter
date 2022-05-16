import 'dart:convert';

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

  Map<String, dynamic> toMap() {
    return {
      'categoryId': categoryId,
      'name': name,
      'avatarId': avatarId,
      'avatar': avatar?.getUrl(AmityImageSize.MEDIUM),
      'metadata': metadata,
      'isDeleted': isDeleted,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  String toJson() => json.encode(toMap());
}
