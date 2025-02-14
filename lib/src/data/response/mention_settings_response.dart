class MentionSettingsResponse {
  final bool? isAllowMentionedChannelEnabled;

  MentionSettingsResponse({
    required this.isAllowMentionedChannelEnabled,
  });

  factory MentionSettingsResponse.fromJson(Map<String, dynamic> json) =>
      MentionSettingsResponse(
          isAllowMentionedChannelEnabled: json['isAllowMentionedChannelEnabled']
      );

  Map<String, dynamic> toJson() => {
        'isAllowMentionedChannelEnabled': isAllowMentionedChannelEnabled
      };
}
