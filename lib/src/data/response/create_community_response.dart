import 'package:amity_sdk/src/data/data.dart';

/// [CreateCommunityResponse]
class CreateCommunityResponse {
  /// Init [CreateCommunityResponse]
  CreateCommunityResponse({
    required this.communities,
    required this.communityUsers,
    required this.files,
    required this.users,
    required this.categories,
    required this.feeds,
    this.paging,
  });

  /// Communities
  final List<CommunityResponse> communities;

  /// community Users
  final List<CommunityUserResponse> communityUsers;

  ///Files
  final List<FileResponse> files;

  /// users
  final List<UserResponse> users;

  /// Category
  final List<CommunityCategoryResponse> categories;

  ///fedds
  final List<CommunityFeedResponse> feeds;

  /// Paging
  final PagingResponse? paging;

  /// [CreateCommunityResponse]
  factory CreateCommunityResponse.fromJson(Map<String, dynamic> json) =>
      CreateCommunityResponse(
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

  ///[CreateCommunityResponse]
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
