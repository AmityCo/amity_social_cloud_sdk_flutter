import 'package:amity_sdk/src/data/response/mention_settings_response.dart';
import 'package:amity_sdk/src/data/response/message_preview_settings_response.dart';

class ChatSettingsResponse {
  final bool? enabled;
  final MentionSettingsResponse? mention;
  final MessagePreviewSettingsResponse? messagePreview;

  ChatSettingsResponse({
    required this.enabled,
    required this.mention,
    required this.messagePreview,
  });

  factory ChatSettingsResponse.fromJson(Map<String, dynamic> json) =>
      ChatSettingsResponse(
          enabled: json['enabled'],
          mention: json['mention'] != null
              ? MentionSettingsResponse.fromJson(json['mention'])
              : null,
          messagePreview: json['messagePreview'] != null
              ? MessagePreviewSettingsResponse.fromJson(json['messagePreview'])
              : null);

  Map<String, dynamic> toJson() => {
        'enabled': enabled,
        'mention': mention?.toJson(),
        'messagePreview': messagePreview?.toJson()
      };
}
