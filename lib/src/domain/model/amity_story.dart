import 'package:amity_sdk/amity_sdk.dart';

class AmityStory {
  String? storyId;
  AmityStoryTargetType? targetType;
  String? targetId;
  AmityStoryDataType? dataType;
  AmityStoryData? data = UnknownStoryData();
  Map<String, dynamic>? rawData;
  List<AmityStoryItem> storyItems = [];
  Map<String, dynamic>? rawStoryItems;
  Map<String, dynamic>? metadata;
  List<String> myReactions = [];
  Map<String, dynamic> reactions = {};
  int reactionCount = 0;
  int commentCount = 0;
  int flagCount = 0;
  bool isDeleted = false;
  DateTime? expiresAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? path;
  int impression = 0;
  int reach = 0;
  AmityUser? creator;
  String? creatorId;
  String? creatorPublicId;
  String? targetPublicId;
  AmityStorySyncState? syncState;
}


