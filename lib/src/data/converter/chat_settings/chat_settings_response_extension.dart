import 'package:amity_sdk/src/core/enum/amity_message_preview_setting.dart';
import 'package:amity_sdk/src/data/data_source/local/hive_entity/chat_settings_hive_entity.dart';
import 'package:amity_sdk/src/data/response/chat_settings_response.dart';

extension ChatSettingsResponseExtension on ChatSettingsResponse {
  ChatSettingsHiveEntity toHiveEntity() {
    final messagePreviewSettings = AmityMessagePreviewSettingExtension.fromMessagePreviewSetting(messagePreview!);
    return ChatSettingsHiveEntity()
      ..enabled = enabled
      ..isAllowMentionedChannelEnabled = mention?.isAllowMentionedChannelEnabled
      ..messagePreviewSetting = messagePreviewSettings.value;
  }
}
