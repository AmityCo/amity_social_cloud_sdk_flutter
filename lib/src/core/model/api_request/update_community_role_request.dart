class UpdateCommunityRoleRequest {
  UpdateCommunityRoleRequest(
      {required this.communityId, required this.userIds, required this.role});

  final String communityId;
  final List<String> userIds;
  final String role;

  Map<String, dynamic> toJson() => {
        "communityId": communityId,
        "role": role,
        "userIds": List<String>.from(userIds.map((x) => x)),
      };
}
