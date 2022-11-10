import 'package:amity_sdk/src/core/model/api_request/core/option_request.dart';

/// [GetChannelMembersRequest]
class GetChannelMembersRequest {
  /// Init [GetChannelMembersRequest]
  GetChannelMembersRequest(
      {required this.channelId,
      this.memberId,
      this.filter,
      this.roles,
      this.sortBy,
      this.options});

  /// Channel Id
  final String channelId;

  /// Member Id
  String? memberId;

  /// Membership
  String? filter;

  /// Roles
  List<String>? roles;

  /// Sort by
  String? sortBy;

  /// Option
  OptionsRequest? options;

  /// [GetChannelMembersRequest] from Map
  factory GetChannelMembersRequest.fromJson(Map<String, dynamic> json) =>
      GetChannelMembersRequest(
        channelId: json["channelId"],
        sortBy: json["sortBy"],
        filter: json["filter"],
        roles: List<String>.from(json["roles"].map((x) => x)),
        options: json["options"] == null
            ? null
            : OptionsRequest.fromJson(json["options"]),
      );

  /// Change [GetChannelMembersRequest] to Map
  Map<String, dynamic> toJson() => {
        "channelId": channelId,
        "sortBy": sortBy,
        "filter": filter,
        "roles":
            roles == null ? null : List<dynamic>.from(roles!.map((x) => x)),
        "options": options?.toJson(),
      }..removeWhere((key, value) => value == null);
}
