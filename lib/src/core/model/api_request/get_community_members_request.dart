import 'dart:convert';

import 'package:amity_sdk/src/core/model/api_request/core/option_request.dart';

class GetCommunityMembersRequest {
  GetCommunityMembersRequest(
      {required this.communityId,
      this.memberships,
      this.roles,
      this.sortBy,
      this.options});

  final String communityId;
  List<String>? memberships;
  List<String>? roles;
  String? sortBy;
  OptionsRequest? options;

  factory GetCommunityMembersRequest.fromJson(Map<String, dynamic> json) =>
      GetCommunityMembersRequest(
        communityId: json["communityId"],
        sortBy: json["sortBy"],
        memberships: List<String>.from(json["memberships"].map((x) => x)),
        roles: List<String>.from(json["roles"].map((x) => x)),
        options: json["options"] == null
            ? null
            : OptionsRequest.fromJson(json["options"]),
      );

  Map<String, dynamic> toJson() => {
        "communityId": communityId,
        "sortBy": sortBy,
        "memberships": memberships == null
            ? null
            : List<dynamic>.from(memberships!.map((x) => x)),
        "roles":
            roles == null ? null : List<dynamic>.from(roles!.map((x) => x)),
        "options": options?.toJson(),
      }..removeWhere((key, value) => value == null);
}
