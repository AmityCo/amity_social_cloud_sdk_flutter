import 'package:amity_sdk/src/core/model/api_request/core/option_request.dart';

/// [GetChannelMembersRequestV4]
class GetChannelMembersRequestV4 {
  /// Init [GetChannelMembersRequestV4]
  GetChannelMembersRequestV4(
      {required this.channelId,
      this.memberId,
      this.memberships,
      this.roles,
      this.sortBy,
      this.options,
      this.keyword});

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

  /// Keyword
  String? keyword;

  /// [GetChannelMembersRequestV4] from Map
  factory GetChannelMembersRequestV4.fromJson(Map<String, dynamic> json) =>
      GetChannelMembersRequestV4(
        channelId: json["channelId"],
        sortBy: json["sortBy"],
        memberships: json["memberships"] == null
            ? null
            : List<String>.from(json["memberships"].map((x) => x)),
        keyword: json["search"],
        roles: json["roles"] == null
            ? null
            : List<String>.from(json["roles"].map((x) => x)),
        options: json["options"] == null
            ? null
            : OptionsRequest.fromJson(json["options"]),
      );

  /// Change [GetChannelMembersRequestV4] to Map
  Map<String, dynamic> toJson() => {
        "channelId": channelId,
        "sortBy": sortBy,
        "memberships[]": memberships == null
            ? null
            : List<dynamic>.from(memberships!.map((x) => x)),
        "search": keyword,
        "roles[]":
            roles == null ? null : List<dynamic>.from(roles!.map((x) => x)),
        "options": options?.toJson(),
      }..removeWhere((key, value) => value == null);
}
