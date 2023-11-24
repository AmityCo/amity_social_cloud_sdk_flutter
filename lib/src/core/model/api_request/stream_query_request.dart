import 'package:amity_sdk/src/core/core.dart';

class StreamQueryRequest {
  StreamQueryRequest(
      {this.isDeleted,
      this.isLive,
      this.options,
      this.sortBy,
      this.stackFromEnd,
      this.statuses,
      this.userPublicIds});

  /// Sort By
  String? sortBy;

  /// Is Deleted
  bool? isDeleted;

  /// Is live
  bool? isLive;

  /// statuses
  List<String>? statuses;

  /// public ids
  List<String>? userPublicIds;

  /// Option
  OptionsRequest? options;

  /// Stack from end, only use internally
  bool? stackFromEnd = false;

  factory StreamQueryRequest.fromJson(Map<String, dynamic> json) =>
      StreamQueryRequest(
        sortBy: json["sortBy"],
        isLive: json["isLive"],
        isDeleted: json["isDeleted"],
        statuses: List<String>.from(json["statuses"].map((x) => x)),
        userPublicIds: List<String>.from(json["userPublicIds"].map((x) => x)),
        options: OptionsRequest.fromJson(json["options"]),
      );

  Map<String, dynamic> toJson() => {
        "sortBy": sortBy,
        // "isLive": isLive,
        // "isDeleted": isDeleted,
        "statuses": statuses==null? null : List<dynamic>.from(statuses!.map((x) => x)),
        // "userPublicIds":userPublicIds==null ? null : List<String>.from(  userPublicIds!.map((x) => x)),
        "options": options!.toJson(),
      };
      
}
