class StoryTargetResponse {
  String? targetType;
  String? targetId;
  String? targetPublicId;
  DateTime? targetUpdatedAt;
  DateTime? lastStoryExpiresAt;
  DateTime? lastStorySeenExpiresAt;


  StoryTargetResponse(
      {this.targetType,
      this.targetId,
      this.targetPublicId,
      this.targetUpdatedAt, 
      this.lastStoryExpiresAt,
      this.lastStorySeenExpiresAt});

  StoryTargetResponse.fromJson(Map<String, dynamic> json) {
    targetType = json['targetType'];
    targetId = json['targetId'];
    targetPublicId = json['targetPublicId'];
    targetUpdatedAt = json['targetUpdatedAt'] == null ? null :  DateTime.tryParse(json['targetUpdatedAt']);
    lastStoryExpiresAt = json['lastStoryExpiresAt'] == null ? null :   DateTime.tryParse(json['lastStoryExpiresAt']) ;
    lastStorySeenExpiresAt = json['lastStorySeenExpiresAt'] == null ? null :   DateTime.tryParse(json['lastStorySeenExpiresAt']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['targetType'] = targetType;
    data['targetId'] = targetId;
    data['targetPublicId'] = targetPublicId;
    data['targetUpdatedAt'] = targetUpdatedAt;
    data['lastStoryExpiresAt'] = lastStoryExpiresAt;
    data['lastStorySeenExpiresAt'] = lastStorySeenExpiresAt;
    return data;
  }
}
