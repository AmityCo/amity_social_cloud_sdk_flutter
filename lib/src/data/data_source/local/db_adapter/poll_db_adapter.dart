import 'package:amity_sdk/src/data/data.dart';

/// Poll Db Adapter
abstract class PollDbAdapter {
  /// Save Poll Entity to Hive
  Future savePollEntity(PollHiveEntity data);

  /// Delete Poll Entity
  Future deletePolllEntity(PollHiveEntity data);

  /// Get Poll Entity from Hive
  PollHiveEntity getPollEntity(String pollId);

  /// Listen Poll Entity
  Stream<PollHiveEntity> listenPollEntity(String pollId);
}
