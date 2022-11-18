// To parse this JSON data, do
//
//     final updateChannelMembersRequest = updateChannelMembersRequestFromJson(jsonString);

import 'dart:convert';

import 'package:amity_sdk/src/core/extension/extension.dart';

UpdateChannelMembersRequest updateChannelMembersRequestFromJson(String str) =>
    UpdateChannelMembersRequest.fromJson(json.decode(str));

String updateChannelMembersRequestToJson(UpdateChannelMembersRequest data) =>
    json.encode(data.toJson());

/// [UpdateChannelMembersRequest]
class UpdateChannelMembersRequest {
  /// Init [UpdateChannelMembersRequest]
  UpdateChannelMembersRequest({
    required this.channelId,
    this.userIds,
    this.mutePeriod,
  });

  /// Channel Id
  final String channelId;

  /// User Ids
  final List<String>? userIds;

  /// Mute Period
  final int? mutePeriod;

  /// [UpdateChannelMembersRequest] from Json
  factory UpdateChannelMembersRequest.fromJson(Map<String, dynamic> json) =>
      UpdateChannelMembersRequest(
        channelId: json["channelId"],
        mutePeriod: json["mutePeriod"],
        userIds: List<String>.from(json["userIds"].map((x) => x)),
      );

  /// Map from [UpdateChannelMembersRequest]
  Map<String, dynamic> toJson() => {
        "channelId": channelId,
        "mutePeriod": mutePeriod,
        "userIds":
            userIds == null ? null : List<dynamic>.from(userIds!.map((x) => x)),
      }..removeNullValue();
}
