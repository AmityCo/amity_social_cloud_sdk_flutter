class StoryDeleteByIdRequest {
  /// Sort By
  String? storyId;

  /// Is Deleted
  bool? permanentDelete;

  StoryDeleteByIdRequest({this.storyId, this.permanentDelete});

  factory StoryDeleteByIdRequest.fromJson(Map<String, dynamic> json) =>
      StoryDeleteByIdRequest(
        storyId: json["storyId"],
        permanentDelete: json["permanent"],
      );

  Map<String, dynamic> toJson() => {
        "storyId": storyId,
        "permanent": permanentDelete,
      };
}
