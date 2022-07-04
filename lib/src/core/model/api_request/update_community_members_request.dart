class UpdateCommunityMembersRequest {
  UpdateCommunityMembersRequest(
      {required this.communityId, required this.userIds});

  final String communityId;
  final List<String> userIds;

  Map<String, dynamic> toJson() => {
        "communityId": communityId,
        "userIds": List<String>.from(userIds.map((x) => x)),
      };
}
