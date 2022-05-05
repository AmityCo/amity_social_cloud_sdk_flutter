import 'package:amity_sdk/src/data/data_source/local/hive_entity/file_hive_entity_4.dart';

abstract class FileDbAdapter {
  Future saveFileEntity(FileHiveEntity entity);
  FileHiveEntity getFileEntity(String fileId);
}
