// To parse this JSON data, do
//
//     final updateChannelRoleRequest = updateChannelRoleRequestFromJson(jsonString);

import 'dart:convert';

import 'package:amity_sdk/src/core/extension/extension.dart';

UpdateChannelRoleRequest updateChannelRoleRequestFromJson(String str) =>
    UpdateChannelRoleRequest.fromJson(json.decode(str));

String updateChannelRoleRequestToJson(UpdateChannelRoleRequest data) =>
    json.encode(data.toJson());

/// [UpdateChannelRoleRequest]
class UpdateChannelRoleRequest {
  /// Init [UpdateChannelRoleRequest]
  UpdateChannelRoleRequest({
    required this.channelId,
    required this.role,
    required this.userIds,
  });

  /// Channel ID
  final String channelId;

  /// roles
  final String role;

  /// User IDs
  final List<String> userIds;

  factory UpdateChannelRoleRequest.fromJson(Map<String, dynamic> json) =>
      UpdateChannelRoleRequest(
        channelId: json["channelId"],
        role: json["role"],
        userIds: List<String>.from(json["userIds"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "channelId": channelId,
        "role": role,
        "userIds": List<dynamic>.from(userIds.map((x) => x)),
      }..removeNullValue();
}
