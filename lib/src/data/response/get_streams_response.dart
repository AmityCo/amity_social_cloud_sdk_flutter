import 'package:amity_sdk/src/data/data.dart';

class GetStreamsResponse{

  GetStreamsResponse({
    required this.streams,
    required this.users,
    required this.files,
    this.paging,
  });

  /// List of streams
  final List<VideoStreamingResponse> streams;

  /// List of User
  final List<UserResponse> users;

  /// List of File
  final List<FileResponse> files;

  /// Paging
  final PagingResponse? paging;

  factory GetStreamsResponse.fromJson(Map<String, dynamic> json) =>
      GetStreamsResponse(
        streams: List<VideoStreamingResponse>.from(
            json["results"]["videoStreamings"].map((x) => VideoStreamingResponse.fromJson(x))),
        users: List<UserResponse>.from(
            json["results"]["users"].map((x) => UserResponse.fromJson(x))),
        files: List<FileResponse>.from(
            json["results"]["files"].map((x) => FileResponse.fromJson(x))),
        paging: json["paging"] == null
            ? null
            : PagingResponse.fromJson(json["paging"]),
      );

      Map<String, dynamic> toJson() => {
        "videoStreamings": List<dynamic>.from(streams.map((x) => x.toJson())),
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
        "files": List<dynamic>.from(files.map((x) => x.toJson())),
        "paging": paging?.toJson(),
      };


      factory GetStreamsResponse.fromEvent(Map<String, dynamic> json) =>
      GetStreamsResponse(
        streams: List<VideoStreamingResponse>.from(
            json["videoStreamings"].map((x) => VideoStreamingResponse.fromJson(x))),
        users: List<UserResponse>.from(
            json["users"].map((x) => UserResponse.fromJson(x))),
        files: List<FileResponse>.from(
            json["files"].map((x) => FileResponse.fromJson(x))),
        paging: json["paging"] == null
            ? null
            : PagingResponse.fromJson(json["paging"]),
      );

}