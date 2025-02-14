import 'dart:convert';

import 'package:amity_sdk/src/core/enum/amity_message_preview_setting.dart';

class AmityChatSettings {
  final bool isEnabled;
  final bool isMentionChannelEnabled;
  final AmityMessagePreviewSetting messagePreviewSetting;

  AmityChatSettings({
    required this.isEnabled,
    required this.isMentionChannelEnabled,
    required this.messagePreviewSetting,
  });

  factory AmityChatSettings.fromJson(Map<String, dynamic> json) {
    return AmityChatSettings(
      isEnabled: json['isEnabled'],
      isMentionChannelEnabled: json['isMentionChannelEnabled'],
      messagePreviewSetting: json['messagePreviewSetting'] != null
          ? AmityMessagePreviewSettingExtension.enumOf(json['messagePreviewSetting'])
          : AmityMessagePreviewSettingExtension.DEFAULT,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isEnabled': isEnabled,
      'isMentionChannelEnabled': isMentionChannelEnabled,
      'messagePreviewSetting': messagePreviewSetting.value,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => toJson();
}
