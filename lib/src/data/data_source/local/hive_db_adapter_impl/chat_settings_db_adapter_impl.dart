import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/enum/amity_error.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/data/data_source/local/db_adapter/chat_settings_db_adapter.dart';
import 'package:hive/hive.dart';
import 'package:amity_sdk/src/data/data_source/local/hive_entity/chat_settings_hive_entity.dart';

class ChatSettingsDbAdapterImpl extends ChatSettingsDbAdapter {
  final DBClient dbClient;

  ChatSettingsDbAdapterImpl({required this.dbClient});
  late Box<ChatSettingsHiveEntity> box;
  Future<ChatSettingsDbAdapterImpl> init() async {
    Hive.registerAdapter(ChatSettingsHiveEntityAdapter(), override: true);
    box = await Hive.openBox<ChatSettingsHiveEntity>('chat_settings_db');
    return this;
  }

  @override
  Future deleteAllSettings() async {
    if (box.isOpen) {
      return await box.clear();
    }
  }
  
  @override
  Future saveSettings(ChatSettingsHiveEntity entity) async {
    return box.put(entity.getId(), entity);
  }

  @override
  ChatSettingsHiveEntity? getSettings() {
    return box.get(ChatSettingsHiveEntity().getId());
  }

  @override
  Stream<ChatSettingsHiveEntity> observeSettings() {
    return box.watch(key: ChatSettingsHiveEntity().getId()).map((event) => event.value);
  }
}
