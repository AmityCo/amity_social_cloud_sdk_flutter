import 'package:amity_sdk/domain/domain.dart';
import 'package:amity_sdk/domain/model/amity_tag.dart';

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
  AmityTags? tags; //Compose
  Map<String, dynamic>? metadata; //Compose
  int? postsCount;
  int? membersCount;
  bool? isJoined;
  bool? isDeleted;
  List<AmityCommunityCategory>? categories; //compose
  AmityUser? user; //Compose
  AmityImage? avatarImage; //Compose
  bool? isPostReviewEnabled;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? path;
}
