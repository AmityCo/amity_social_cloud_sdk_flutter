// To parse this JSON data, do
//
//     final createPostResponse = createPostResponseFromJson(jsonString);

import 'dart:convert';

import 'package:amity_sdk/src/data/data.dart';

CreatePostResponse createPostResponseFromJson(String str) =>
    CreatePostResponse.fromJson(json.decode(str));

String createPostResponseToJson(CreatePostResponse data) =>
    json.encode(data.toJson());

class CreatePostResponse {
  CreatePostResponse({
    required this.posts,
    required this.postChildren,
    required this.comments,
    required this.users,
    required this.files,
    required this.communities,
    required this.communityUsers,
    required this.categories,
    required this.feeds,
    required this.videoStreamings,
    required this.polls,
    required this.paging,
  });

  final List<PostResponse> posts;
  final List<PostResponse> postChildren;
  final List<CommentResponse> comments;
  final List<UserResponse> users;
  final List<FileResponse> files;
  final List<CommunityResponse> communities;
  final List<CommunityUserResponse> communityUsers;
  final List<CategoryResponse> categories;
  final List<FeedResponse> feeds;
  final List<VideoStreamingResponse> videoStreamings;
  final List<PollResponse> polls;
  final PagingResponse? paging;

  factory CreatePostResponse.fromJson(Map<String, dynamic> json) =>
      CreatePostResponse(
        posts: json["posts"] == null
            ? []
            : List<PostResponse>.from(
                json["posts"].map((x) => PostResponse.fromJson(x))),
        postChildren: json["postChildren"] == null
            ? []
            : List<PostResponse>.from(
                json["postChildren"].map((x) => PostResponse.fromJson(x))),
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
            : List<CategoryResponse>.from(
                json["categories"].map((x) => CategoryResponse.fromJson(x))),
        feeds: json["feeds"] == null
            ? []
            : List<FeedResponse>.from(
                json["feeds"].map((x) => FeedResponse.fromJson(x))),
        videoStreamings: json["videoStreamings"] == null
            ? []
            : List<VideoStreamingResponse>.from(json["videoStreamings"]
                .map((x) => VideoStreamingResponse.fromJson(x))),
        polls: json["polls"] == null
            ? []
            : List<PollResponse>.from(
                json["polls"].map((x) => PollResponse.fromJson(x))),
        paging: json["paging"] == null
            ? null
            : PagingResponse.fromJson(json['paging']),
      );

  Map<String, dynamic> toJson() => {
        "posts": List<dynamic>.from(posts.map((x) => x.toJson())),
        "postChildren": List<dynamic>.from(postChildren.map((x) => x.toJson())),
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
        "files": List<dynamic>.from(files.map((x) => x.toJson())),
        "communities": List<dynamic>.from(communities.map((x) => x.toJson())),
        "communityUsers":
            List<dynamic>.from(communityUsers.map((x) => x.toJson())),
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "feeds": List<dynamic>.from(feeds.map((x) => x.toJson())),
        "videoStreamings":
            List<dynamic>.from(videoStreamings.map((x) => x.toJson())),
        "polls": List<dynamic>.from(polls.map((x) => x.toJson())),
        "paging": paging,
      };
}
