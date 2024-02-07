import 'package:amity_sdk/src/core/extension/extension.dart';

class GetReachUserRequest{
  String? token;
  String? postId;
  String? storyId;
  int? limit;

  GetReachUserRequest({this.token, this.postId, this.limit});

  GetReachUserRequest.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    postId = json['postId'];
    limit = json['limit'];
    storyId = json['storyId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['postId'] = postId;
    data['limit'] = limit;
    data['storyId'] = storyId;
    return data..removeNullValue();
  }

}