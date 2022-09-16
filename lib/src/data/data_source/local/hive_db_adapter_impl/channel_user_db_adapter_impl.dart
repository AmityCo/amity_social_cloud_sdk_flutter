import 'package:amity_sdk/src/data/data.dart';
import 'package:hive/hive.dart';

/// [ChannelUserDbAdapterImpl]
class ChannelUserDbAdapterImpl extends ChannelUserDbAdapter {
  /// Db Client
  final DBClient dbClient;

  /// Box
  late Box box;

  /// init [ChannelUserDbAdapterImpl]
  ChannelUserDbAdapterImpl({required this.dbClient});

  /// Init [ChannelDbAdapterImpl]
  Future<ChannelUserDbAdapterImpl> init() async {
    Hive.registerAdapter(ChannelUserHiveEntityAdapter(), override: true);
    box = await Hive.openBox<ChannelUserHiveEntity>('channel_user_db');
    return this;
  }

  @override
  Future deleteEntity(ChannelUserHiveEntity data) async {
    box.delete(data.channelId);
  }

  @override
  ChannelUserHiveEntity? getEntity(String id) {
    return box.get(id);
  }

  @override
  Stream<ChannelUserHiveEntity> listenEntity(String id) {
    return box.watch(key: id).map((event) => event.value);
  }

  @override
  Future saveEntity(ChannelUserHiveEntity data) async {
    box.put(data.id, data);
  }
}
