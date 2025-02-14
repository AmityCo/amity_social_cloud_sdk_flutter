import 'package:amity_sdk/src/core/model/api_request/core/option_request.dart';
import 'package:amity_sdk/src/core/utils/amity_nonce.dart';

class GetCommunityMembersRequest {
  GetCommunityMembersRequest(
      {required this.communityId,
      this.keyword,
      this.memberships,
      this.roles,
      this.sortBy,
      this.isDeleted,
      this.options});

  final String communityId;
  String? keyword;
  List<String>? memberships;
  List<String>? roles;
  bool? isDeleted;
  String? sortBy;
  OptionsRequest? options;

  Map<String, dynamic> toJson() => {
        "communityId": communityId,
        "search": keyword,
        "sortBy": sortBy,
        "isDeleted": isDeleted,
        "memberships": memberships == null
            ? null
            : List<dynamic>.from(memberships!.map((x) => x)),
        "roles":
            roles == null ? null : List<dynamic>.from(roles!.map((x) => x)),
        "options": options?.toJson(),
      }..removeWhere((key, value) => value == null);


  int getHashCode() {
    final jsonString = (toJson()..remove('options')).toString();
    return jsonString.hashCode;
  }

  AmityNonce getNonce() {
    return AmityNonce.COMMUNITY_MEMBER_LIST;
  }
}
