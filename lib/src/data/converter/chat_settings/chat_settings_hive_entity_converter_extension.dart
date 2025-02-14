import 'package:amity_sdk/src/core/enum/amity_message_preview_setting.dart';
import 'package:amity_sdk/src/data/data_source/local/hive_entity/chat_settings_hive_entity.dart';
import 'package:amity_sdk/src/domain/model/amity_chat_settings.dart';

extension ChatSettingsHiveEntityExtension on ChatSettingsHiveEntity {
  AmityChatSettings convertToAmityChatSettings() {
    return AmityChatSettings(
      isEnabled: enabled ?? false,
      isMentionChannelEnabled: isAllowMentionedChannelEnabled ?? false,
      messagePreviewSetting: messagePreviewSetting != null
          ? AmityMessagePreviewSettingExtension.enumOf(messagePreviewSetting!)
          : AmityMessagePreviewSettingExtension.DEFAULT,
    );
  }
}
