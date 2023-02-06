import 'package:amity_sdk/src/core/model/api_request/core/option_request.dart';

class GetCommunityMembersRequest {
  GetCommunityMembersRequest(
      {required this.communityId,
      this.keyword,
      this.memberships,
      this.roles,
      this.sortBy,
      this.options});

  final String communityId;
  String? keyword;
  List<String>? memberships;
  List<String>? roles;
  String? sortBy;
  OptionsRequest? options;

  Map<String, dynamic> toJson() => {
        "communityId": communityId,
        "search": keyword,
        "sortBy": sortBy,
        "memberships": memberships == null
            ? null
            : List<dynamic>.from(memberships!.map((x) => x)),
        "roles":
            roles == null ? null : List<dynamic>.from(roles!.map((x) => x)),
        "options": options?.toJson(),
      }..removeWhere((key, value) => value == null);
}
