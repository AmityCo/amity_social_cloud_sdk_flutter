import 'package:amity_sdk/src/data/data_source/local/db_client/abs_db_client.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' if (dart.library.html) ''
    as path_provider;

class HiveDbClient extends DBClient {
  @override
  Future<HiveDbClient> init() async {
    //initialized Hive
    // final appDocumentDirectory = await getApplicationDocumentsDirectory();
    // var path = Directory.current.path;
    // print('path >>>>>> $path');
    if (!kIsWeb) {
      var appDir = await path_provider.getApplicationDocumentsDirectory();
      Hive.init(appDir.path);
    }

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
