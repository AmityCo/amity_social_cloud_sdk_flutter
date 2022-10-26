import 'package:amity_sdk/src/data/data.dart';
import 'package:hive/hive.dart';

/// [ChannelDbAdapterImpl]
class ChannelDbAdapterImpl extends ChannelDbAdapter {
  /// Db Client
  final DBClient dbClient;

  /// Box
  late Box box;

  /// init [ChannelDbAdapterImpl]
  ChannelDbAdapterImpl({required this.dbClient});

  /// Init [ChannelDbAdapterImpl]
  Future<ChannelDbAdapterImpl> init() async {
    Hive.registerAdapter(ChannelHiveEntityAdapter(), override: true);
    box = await Hive.openBox<ChannelHiveEntity>('channel_db');
    return this;
  }

  @override
  Future deleteEntity(ChannelHiveEntity data) async {
    box.delete(data.channelId);
  }

  @override
  ChannelHiveEntity getEntity(String id) {
    return box.get(id);
  }

  @override
  Stream<ChannelHiveEntity> listenEntity(String id) {
    return box.watch(key: id).map((event) => event.value);
  }

  @override
  Future saveEntity(ChannelHiveEntity data) async {
    await box.put(data.channelId, data);
  }
}
