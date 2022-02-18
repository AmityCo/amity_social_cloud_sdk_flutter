import 'package:amity_sdk/data/data.dart';
import 'package:amity_sdk/data/data_source/local/db_adapter/file_db_adapter.dart';
import 'package:amity_sdk/data/data_source/local/hive_entity/file_hive_entity_4.dart';
import 'package:hive/hive.dart';

class FileDbAdapterImpl extends FileDbAdapter {
  final DBClient dbClient;

  FileDbAdapterImpl({required this.dbClient});
  late Box box;
  Future<FileDbAdapterImpl> init() async {
    Hive.registerAdapter(FileHiveEntityAdapter());
    box = await Hive.openBox<FileHiveEntity>('file_db');
    return this;
  }

  @override
  FileHiveEntity getFileEntity(String fileId) {
    return box.get(fileId);
  }

  @override
  Future saveFileEntity(FileHiveEntity entity) async {
    await box.put(entity.fileId, entity);
  }
}
