class MessagePreviewSettingsResponse {
  final bool? enabled;
  final bool? isIncludeDeleted;

  MessagePreviewSettingsResponse({
    required this.enabled,
    required this.isIncludeDeleted,
  });

  factory MessagePreviewSettingsResponse.fromJson(Map<String, dynamic> json) =>
      MessagePreviewSettingsResponse(
          enabled: json['enabled'],
          isIncludeDeleted: json['isIncludeDeleted']
      );

  Map<String, dynamic> toJson() => {
        'enabled': enabled,
        'isIncludeDeleted': isIncludeDeleted
      };

  bool get isEnabled => enabled ?? false;
  bool get isIncludeDeletedEnabled => isIncludeDeleted ?? true;
}
