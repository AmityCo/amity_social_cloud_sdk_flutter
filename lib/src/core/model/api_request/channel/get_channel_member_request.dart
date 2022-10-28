import 'package:amity_sdk/src/core/model/api_request/core/option_request.dart';

/// [GetChannelMembersRequest]
class GetChannelMembersRequest {
  /// Init [GetChannelMembersRequest]
  GetChannelMembersRequest(
      {required this.channelId,
      this.memberId,
      this.memberships,
      this.roles,
      this.sortBy,
      this.options});

  /// Channel Id
  final String channelId;

  /// Member Id
  String? memberId;

  /// Membership
  List<String>? memberships;

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
        memberships: List<String>.from(json["memberships"].map((x) => x)),
        roles: List<String>.from(json["roles"].map((x) => x)),
        options: json["options"] == null
            ? null
            : OptionsRequest.fromJson(json["options"]),
      );

  /// Change [GetChannelMembersRequest] to Map
  Map<String, dynamic> toJson() => {
        "channelId": channelId,
        "sortBy": sortBy,
        "memberships": memberships == null
            ? null
            : List<dynamic>.from(memberships!.map((x) => x)),
        "roles":
            roles == null ? null : List<dynamic>.from(roles!.map((x) => x)),
        "options": options?.toJson(),
      }..removeWhere((key, value) => value == null);
}
