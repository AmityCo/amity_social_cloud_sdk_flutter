// To parse this JSON data, do
//
//     final updateChannelMembersRequest = updateChannelMembersRequestFromJson(jsonString);

import 'dart:convert';

UpdateChannelMembersRequest updateChannelMembersRequestFromJson(String str) =>
    UpdateChannelMembersRequest.fromJson(json.decode(str));

String updateChannelMembersRequestToJson(UpdateChannelMembersRequest data) =>
    json.encode(data.toJson());

/// [UpdateChannelMembersRequest]
class UpdateChannelMembersRequest {
  /// Init [UpdateChannelMembersRequest]
  UpdateChannelMembersRequest({
    required this.channelId,
    required this.userIds,
  });

  /// Channel Id
  final String channelId;

  /// User Ids
  final List<String> userIds;

  /// [UpdateChannelMembersRequest] from Json
  factory UpdateChannelMembersRequest.fromJson(Map<String, dynamic> json) =>
      UpdateChannelMembersRequest(
        channelId: json["channelId"],
        userIds: List<String>.from(json["userIds"].map((x) => x)),
      );

  /// Map from [UpdateChannelMembersRequest]
  Map<String, dynamic> toJson() => {
        "channelId": channelId,
        "userIds": List<dynamic>.from(userIds.map((x) => x)),
      };
}
