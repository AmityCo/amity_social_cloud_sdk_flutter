import 'package:amity_sdk/src/data/data.dart';
import 'package:hive/hive.dart';

/// Implement for Poll Db Adater
class PollDbAdapterImpl extends PollDbAdapter {
  /// Init Poll Db Adater
  PollDbAdapterImpl({required this.dbClient});

  /// Hive Db Client
  final DBClient dbClient;

  /// Hive Boc
  late Box box;

  /// Async Init Db Adapter
  Future<PollDbAdapter> init() async {
    Hive.registerAdapter(PollHiveEntityAdapter(), override: true);
    box = await Hive.openBox<PollHiveEntity>('poll_db');
    return this;
  }

  /// Delete Poll Hive Entity
  @override
  Future deletePolllEntity(PollHiveEntity data) async {
    await box.delete(data.pollId);
  }

  /// Get Poll Entity
  @override
  PollHiveEntity getPollEntity(String pollId) {
    return box.get(pollId);
  }

  /// Listen Poll Entity
  @override
  Stream<PollHiveEntity> listenPollEntity(String pollId) {
    return box.watch(key: pollId).map((event) => event.value);
  }

  /// Save Poll Hive Entity
  @override
  Future savePollEntity(PollHiveEntity data) async {
    await box.put(data.pollId, data);
  }
}
