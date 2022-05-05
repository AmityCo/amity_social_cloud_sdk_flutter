import 'package:amity_sdk/src/data/data.dart';

class CreateCommunityResponse {
  CreateCommunityResponse(
      {required this.communities,
      required this.communityUsers,
      required this.files,
      required this.users,
      required this.categories,
      required this.feeds});

  final List<CommunityResponse> communities;
  final List<CommunityUserResponse> communityUsers;
  final List<FileResponse> files;
  final List<UserResponse> users;
  final List<CategoryResponse> categories;
  final List<FeedResponse> feeds;

  factory CreateCommunityResponse.fromJson(Map<String, dynamic> json) => CreateCommunityResponse(
      communities: json["communities"] == null
          ? []
          : List<CommunityResponse>.from(
              json["communities"].map((x) => CommunityResponse.fromJson(x))),
      communityUsers: json["communityUsers"] == null
          ? []
          : List<CommunityUserResponse>.from(json["communityUsers"]
              .map((x) => CommunityUserResponse.fromJson(x))),
      files: json["files"] == null
          ? []
          : List<FileResponse>.from(
              json["files"].map((x) => FileResponse.fromJson(x))),
      users: json["users"] == null
          ? []
          : List<UserResponse>.from(
              json["users"].map((x) => UserResponse.fromJson(x))),
      categories: json["categories"] == null
          ? []
          : List<CategoryResponse>.from(
              json["categories"].map((x) => CategoryResponse.fromJson(x))),
      feeds: json["feeds"] == null
          ? []
          : List<FeedResponse>.from(json["feeds"].map((x) => FeedResponse.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "communities": List<dynamic>.from(communities.map((x) => x.toJson())),
        "communityUsers":
            List<dynamic>.from(communityUsers.map((x) => x.toJson())),
        "files": List<dynamic>.from(files.map((x) => x.toJson())),
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "feeds": List<dynamic>.from(feeds.map((x) => x.toJson())),
      };
}
