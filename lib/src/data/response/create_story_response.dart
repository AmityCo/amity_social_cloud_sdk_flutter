import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/data/response/core_response/story_target_response.dart';

class CreateStoryResponse {
  final List<StoryResponse> stories;
  final List<CommentResponse> comments;
  final List<UserResponse> users;
  final List<FileResponse> files;
  final List<CommunityResponse> communities;
  final List<CommunityUserResponse> communityUsers;
  final List<CommunityCategoryResponse> categories;
  final List<StoryTargetResponse> storyTargets;

  CreateStoryResponse(
      {required this.stories,
      required this.comments,
      required this.users,
      required this.files,
      required this.communities,
      required this.communityUsers,
      required this.categories,
      required this.storyTargets});

  factory CreateStoryResponse.fromJson(Map<String, dynamic> json) =>
      CreateStoryResponse(
        stories: json["stories"] == null
            ? []
            : List<StoryResponse>.from(
                json["stories"].map((x) => StoryResponse.fromJson(x))),
        comments: json["comments"] == null
            ? []
            : List<CommentResponse>.from(
                json["comments"].map((x) => CommentResponse.fromJson(x))),
        users: json["users"] == null
            ? []
            : List<UserResponse>.from(
                json["users"].map((x) => UserResponse.fromJson(x))),
        files: json["files"] == null
            ? []
            : List<FileResponse>.from(
                json["files"].map((x) => FileResponse.fromJson(x))),
        communities: json["communities"] == null
            ? []
            : List<CommunityResponse>.from(
                json["communities"].map((x) => CommunityResponse.fromJson(x))),
        communityUsers: json["communityUsers"] == null
            ? []
            : List<CommunityUserResponse>.from(json["communityUsers"]
                .map((x) => CommunityUserResponse.fromJson(x))),
        categories: json["categories"] == null
            ? []
            : List<CommunityCategoryResponse>.from(json["categories"]
                .map((x) => CommunityCategoryResponse.fromJson(x))),
        storyTargets: json["storyTargets"] == null
            ? []
            : List<StoryTargetResponse>.from(json["storyTargets"]
                .map((x) => StoryTargetResponse.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "stories": List<dynamic>.from(stories.map((x) => x.toJson())),
        "comments": List<dynamic>.from(comments.map((x) => x)),
        "users": List<dynamic>.from(users.map((x) => x)),
        "files": List<dynamic>.from(files.map((x) => x)),
        "communities": List<dynamic>.from(communities.map((x) => x)),
        "communityUsers": List<dynamic>.from(communityUsers.map((x) => x)),
        "categories": List<dynamic>.from(categories.map((x) => x)),
        "storyTargets": List<dynamic>.from(storyTargets.map((x) => x)),
      };
}
