import 'package:amity_sdk/data/data_source/local/db_client/abs_db_client.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveDbClient extends DBClient {
  Future<HiveDbClient> init() async {
    //initialized Hive
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
    return this;
  }
}
