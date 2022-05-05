// To parse this JSON data, do
//
//     final usersRequest = usersRequestFromJson(jsonString);

import 'dart:convert';

import 'core/option_request.dart';

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
  OptionsRequest? options;

  factory UsersRequest.fromJson(Map<String, dynamic> json) => UsersRequest(
        keyword: json["keyword"],
        filter: json["filter"],
        sortBy: json["sortBy"],
        options: OptionsRequest.fromJson(json["options"]),
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    if (keyword != null) data['keyboard'] = keyword;
    if (filter != null) data['filter'] = filter;
    if (sortBy != null) data['sortBy'] = sortBy;
    if (options != null) data['options'] = options!.toJson();
    return data;
  }

  @override
  String toString() {
    return usersRequestToJson(this);
  }
}
