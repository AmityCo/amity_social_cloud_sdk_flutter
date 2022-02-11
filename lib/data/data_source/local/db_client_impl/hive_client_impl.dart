import 'package:amity_sdk/data/data_source/local/db_client/abs_db_client.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveDbClient extends DBClient {
  Future<HiveDbClient> init() async {
    await Hive.initFlutter();
    return this;
  }
}
