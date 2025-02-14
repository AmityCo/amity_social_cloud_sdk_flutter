import 'package:amity_sdk/src/core/utils/amity_hive_type.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:hive/hive.dart';

part 'chat_settings_hive_entity.g.dart';

@HiveType(typeId: AmityHiveType.chatSettings)
class ChatSettingsHiveEntity extends EkoObject {
  @HiveField(0)
  String settingId = "CHAT_SETTINGS_ID";

  @HiveField(1)
  bool? enabled;

  @HiveField(2)
  bool? isAllowMentionedChannelEnabled;

  @HiveField(3)
  String? messagePreviewSetting;

  @HiveField(4)
  DateTime? createdAt;

  @HiveField(5)
  DateTime? updatedAt;

  @override
  String? getId() {
    return settingId;
  }
}
