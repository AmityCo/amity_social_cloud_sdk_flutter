import 'package:amity_sdk/src/core/core.dart';

class FollowRequest {
  FollowRequest({
    this.userId,
    this.status,
    this.limit,
    this.token,
  });
  String? userId;
  String? status;
  int? limit;
  String? token;

  factory FollowRequest.fromJson(Map<String, dynamic> json) => FollowRequest(
        status: json["status"],
        limit: json["limit"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "limit": limit,
        "token": token,
      }..removeWhere((key, value) => value == null);

  @override
  String toString() {
    return toJson().toJson();
  }
}
