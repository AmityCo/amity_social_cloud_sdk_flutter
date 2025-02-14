
import 'package:amity_sdk/src/data/response/message_preview_settings_response.dart';

enum AmityMessagePreviewSetting {
  NO_MESSAGE_PREVIEW,
  MESSAGE_PREVIEW_INCLUDE_DELETED,
  MESSAGE_PREVIEW_NOT_INCLUDE_DELETED,
}

extension AmityMessagePreviewSettingExtension on AmityMessagePreviewSetting {
  static final DEFAULT = AmityMessagePreviewSetting.NO_MESSAGE_PREVIEW;

  String get value {
    return AmityMessagePreviewSetting.values[index].name;
  
  }

  static AmityMessagePreviewSetting enumOf(String value) {
    return AmityMessagePreviewSetting.values.firstWhere(
      (element) => element.name.toLowerCase() == value.toLowerCase(),
      orElse: () => DEFAULT,
    );
  }

  static AmityMessagePreviewSetting fromMessagePreviewSetting(MessagePreviewSettingsResponse setting) {
    if (setting.isEnabled && setting.isIncludeDeletedEnabled) {
      return AmityMessagePreviewSetting.MESSAGE_PREVIEW_INCLUDE_DELETED;
    } else if (setting.isEnabled && !setting.isIncludeDeletedEnabled) {
      return AmityMessagePreviewSetting.MESSAGE_PREVIEW_NOT_INCLUDE_DELETED;
    } else if (!setting.isEnabled) {
      return AmityMessagePreviewSetting.NO_MESSAGE_PREVIEW;
    } else {
      return DEFAULT;
    }
  }
}
