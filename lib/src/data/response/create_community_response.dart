import 'package:amity_sdk/src/data/data.dart';

class CreateCommunityResponse {
  CreateCommunityResponse({
    required this.communities,
    required this.communityUsers,
    required this.files,
    required this.users,
    required this.categories,
    required this.feeds,
    this.paging,
  });

  final List<CommunityResponse> communities;
  final List<CommunityUserResponse> communityUsers;
  final List<FileResponse> files;
  final List<UserResponse> users;
  final List<CommunityCategoryResponse> categories;
  final List<CommunityFeedResponse> feeds;
  final PagingResponse? paging;

  factory CreateCommunityResponse.fromJson(Map<String, dynamic> json) =>
      CreateCommunityResponse(
        communityUsers: json["communityUsers"] == null
            ? []
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
            : List<CommunityCategoryResponse>.from(json["categories"]
                .map((x) => CommunityCategoryResponse.fromJson(x))),
        feeds: json["feeds"] == null
            ? []
            : List<CommunityFeedResponse>.from(json["feeds"].map(
                (x) => CommunityFeedResponse.fromJson(x),
              )),
        paging: json["paging"] == null
            ? null
            : PagingResponse.fromJson(json['paging']),
      );

  Map<String, dynamic> toJson() => {
        "communities": List<dynamic>.from(communities.map((x) => x.toJson())),
        "communityUsers":
            List<dynamic>.from(communityUsers.map((x) => x.toJson())),
        "files": List<dynamic>.from(files.map((x) => x.toJson())),
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "feeds": List<dynamic>.from(feeds.map((x) => x.toJson())),
        "paging": paging,
      };
}
