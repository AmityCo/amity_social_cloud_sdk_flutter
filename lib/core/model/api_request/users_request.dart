// To parse this JSON data, do
//
//     final usersRequest = usersRequestFromJson(jsonString);

import 'dart:convert';

UsersRequest usersRequestFromJson(String str) =>
    UsersRequest.fromJson(json.decode(str));

String usersRequestToJson(UsersRequest data) => json.encode(data.toJson());

class UsersRequest {
  UsersRequest({
    this.keyword,
    this.filter,
    this.sortBy,
    this.options,
  });

  String? keyword;
  String? filter;
  String? sortBy;
  Options? options;

  factory UsersRequest.fromJson(Map<String, dynamic> json) => UsersRequest(
        keyword: json["keyword"],
        filter: json["filter"],
        sortBy: json["sortBy"],
        options: Options.fromJson(json["options"]),
      );

  Map<String, dynamic> toJson() => {
        "keyword": keyword,
        "filter": filter,
        "sortBy": sortBy,
        "options": options == null ? {} : options!.toJson(),
      };

  @override
  String toString() {
    return usersRequestToJson(this);
  }
}

class Options {
  Options({
    this.limit,
    this.token,
  });

  int? limit;
  String? token;

  factory Options.fromJson(Map<String, dynamic> json) => Options(
        limit: json["limit"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "limit": limit,
        "token": token,
      };
}
