import 'package:amity_sdk/domain/domain.dart';
import 'package:amity_sdk/domain/model/amity_community_category.dart';
import 'package:amity_sdk/domain/model/amity_tag.dart';
import 'package:amity_sdk/domain/model/amity_user.dart';

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
  AmityTags? tags;
  Map<String, dynamic>? metadata;
  int? postsCount;
  int? membersCount;
  bool? isJoined;
  bool? isDeleted;
  List<AmityCommunityCategory>? categories;
  AmityUser? user;
  AmityImage? avatarImage;
  bool? isPostReviewEnabled;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? path;
}
