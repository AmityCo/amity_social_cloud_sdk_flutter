import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/utils/amity_nonce.dart';

class FollowRequest {
  FollowRequest(
      {this.userId,
      this.status,
      this.limit,
      this.token,
      this.options,
      this.stackFromEnd});
  String? userId;
  String? status;
  int? limit;
  String? token;

  /// Option
  OptionsRequest? options;

  /// Stack from end, only use internally
  bool? stackFromEnd = false;

  factory FollowRequest.fromJson(Map<String, dynamic> json) => FollowRequest(
        status: json["status"],
        limit: json["limit"],
        token: json["token"],
        options: OptionsRequest.fromJson(json["options"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "limit": limit,
        "token": token,
        "options": options?.toJson(),
      }..removeWhere((key, value) => value == null);

  @override
  String toString() {
    return toJson().toJson();
  }

  int getHashCode() {
    final jsonMap = toJson()..remove('options');
    if (userId != null) {
      final jsonString = jsonMap.toString() + userId!;
      return jsonString.hashCode;
    } else {
      return jsonMap.toString().hashCode;
    }
  }

  AmityNonce getFollowingNonce() {
    return AmityNonce.FOLLOWING_LIST;
  }

  AmityNonce getFollowerNonce() {
    return AmityNonce.FOLLOWER_LIST;
  }
}
