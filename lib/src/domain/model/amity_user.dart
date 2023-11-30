import 'dart:async';
import 'dart:convert';

import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// Amity User
class AmityUser {
  /// doc id
  String? id;

  /// user Id
  String? userId;

  /// User roles for the community
  List<String>? roles;

  /// Display name
  String? displayName;

  /// Description
  String? description;

  /// Avatart file Id
  String? avatarFileId;

  /// Avatar Url
  String? avatarUrl;

  /// User Path
  String? path;

  /// Avatar Custom Url
  String? avatarCustomUrl;

  /// Flag count for the user
  int? flagCount;

  /// Hash Flag
  Map<String, dynamic>? hashFlag;

  /// Metadata for the user
  Map<String, dynamic>? metadata;

  /// Flag to check if user ban globally
  bool? isGlobalBan;

  /// User created date
  DateTime? createdAt;

  /// User updated date
  DateTime? updatedAt;

  /// Flagged By Me
  bool? _flaggedByMe;

  /// Convert [AmityUser] to Map object
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'roles': roles,
      'displayName': displayName,
      'description': description,
      'avatarFileId': avatarFileId,
      'avatarUrl': avatarUrl,
      'avatarCustomUrl': avatarCustomUrl,
      'flagCount': flagCount,
      'metadata': metadata,
      'isGlobalBan': isGlobalBan,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  /// Encode the [AmityUser] object
  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'AmityUser(id: $id, userId: $userId, roles: $roles, displayName: $displayName, description: $description, avatarFileId: $avatarFileId, avatarUrl: $avatarUrl, avatarCustomUrl: $avatarCustomUrl, flagCount: $flagCount, hashFlag: $hashFlag, metadata: $metadata, isGlobalBan: $isGlobalBan, createdAt: $createdAt, updatedAt: $updatedAt, flaggedByMe: $_flaggedByMe)';
  }

  StreamController<AmityUser> get listen {
    StreamController<AmityUser> controller = StreamController<AmityUser>();

    serviceLocator<UserDbAdapter>().listenEntity(userId!).listen((event) {
      final amityUser = event.convertToAmityUser();

      //TOOD: Good idea would be have compose method inside the object itself
      serviceLocator<UserComposerUsecase>().get(amityUser).then(
            (value) => controller.add(value),
          );
    });

    return controller;
  }

  /* begin_public_function 
  id: user.check_flag_by_me
  */
  /// check if user is flagged by me
  bool get isFlaggedByMe {
    if (hashFlag == null) return false;
    return (_flaggedByMe ?? false) ||
        BloomFilter(hash: (hashFlag!['hash'] as String), m: hashFlag!['bits'] as int, k: hashFlag!['hashes'] as int)
            .mightContains(AmityCoreClient.getUserId());
  }
  //* end_public_function */

}
