import 'package:amity_sdk/src/data/data.dart';
import 'package:hive/hive.dart';

class FileDbAdapterImpl extends FileDbAdapter {
  final DBClient dbClient;

  FileDbAdapterImpl({required this.dbClient});
  late Box box;
  Future<FileDbAdapterImpl> init() async {
    Hive.registerAdapter(FileHiveEntityAdapter(), override: true);
    box = await Hive.openBox<FileHiveEntity>('file_db');
    return this;
  }

  @override
  FileHiveEntity? getFileEntity(String fileId) {
    return box.get(fileId);
  }

  @override
  Future saveFileEntity(FileHiveEntity entity) async {
    await box.put(entity.fileId, entity);
  }
}
