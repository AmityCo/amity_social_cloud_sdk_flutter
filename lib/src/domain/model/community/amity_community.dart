import 'dart:async';
import 'dart:convert';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class AmityCommunity {
  String? communityId;
  String? channelId;
  String? userId;
  String? displayName;
  String? description;
  String? avatarFileId;
  bool? isOfficial;
  bool? isPublic;
  bool? onlyAdminCanPost;
  Map<String, dynamic>? metadata;
  int? postsCount;
  int? membersCount;
  bool? isJoined;
  bool? isDeleted;
  List<String>? categoryIds;
  List<String>? tags;
  List<AmityCommunityCategory?>? categories; //compose
  AmityUser? user; //Compose
  AmityImage? avatarImage; //Compose
  bool? isPostReviewEnabled;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? path;

  Map<String, dynamic> toMap() {
    return {
      'communityId': communityId,
      'channelId': channelId,
      'userId': userId,
      'displayName': displayName,
      'description': description,
      'avatarFileId': avatarFileId,
      'isOfficial': isOfficial,
      'isPublic': isPublic,
      'onlyAdminCanPost': onlyAdminCanPost,
      'metadata': metadata,
      'postsCount': postsCount,
      'membersCount': membersCount,
      'isJoined': isJoined,
      'isDeleted': isDeleted,
      'categoryIds': categoryIds,
      'categories': categories?.map((x) => x?.toMap()).toList(),
      'tags': tags,
      'user': user?.toMap(),
      'avatarImage': avatarImage?.getUrl(AmityImageSize.MEDIUM),
      'isPostReviewEnabled': isPostReviewEnabled,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
      'path': path,
    };
  }

  Stream<AmityCommunity> get listen {
    StreamController<AmityCommunity> controller =
        StreamController<AmityCommunity>();

    serviceLocator<CommunityDbAdapter>()
        .listenCommunityEntity(communityId!)
        .listen((event) {
      final updateAmityCommunity = event.convertToAmityCommunity();

      //TOOD: Good idea would be have compose method inside the object itself
      serviceLocator<CommunityComposerUsecase>().get(updateAmityCommunity).then(
            (value) => controller.add(value),
          );
    });

    return controller.stream;
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => toJson();
}
