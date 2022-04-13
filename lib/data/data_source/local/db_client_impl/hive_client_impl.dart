import 'package:amity_sdk/data/data_source/local/db_client/abs_db_client.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveDbClient extends DBClient {
  @override
  Future<HiveDbClient> init() async {
    //initialized Hive
    // final appDocumentDirectory = await getApplicationDocumentsDirectory();
    // var path = Directory.current.path;
    // print('path >>>>>> $path');
    await Hive.initFlutter();

    return this;
  }

  @override
  Future<void> reset() async {
    //initialized Hive
    // final appDocumentDirectory = await getApplicationDocumentsDirectory();
    // var path = Directory.current.path;
    // print('path >>>>>> $path');
    await Hive.deleteFromDisk();

    return;
  }
}
