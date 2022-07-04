import 'package:amity_sdk/src/data/data_source/local/db_client/abs_db_client.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:hive_flutter/hive_flutter.dart';

class HiveDbClient extends DBClient {
  @override
  Future<HiveDbClient> init() async {
    //initialized Hive
    // final appDocumentDirectory = await getApplicationDocumentsDirectory();
    // var path = Directory.current.path;
    // print('path >>>>>> $path');
    var appDir = await getApplicationDocumentsDirectory();
    Hive.init(appDir.path);

    return this;
  }

  @override
  Future<void> reset() async {
    //initialized Hive
    // final appDocumentDirectory = await getApplicationDocumentsDirectory();
    // var path = Directory.current.path;
    await Hive.deleteFromDisk();

    return;
  }
}
