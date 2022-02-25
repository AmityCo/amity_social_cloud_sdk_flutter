import 'package:amity_sdk/data/data_source/local/hive_entity/file_hive_entity_4.dart';

extension FileHiveEntityExtension on FileHiveEntity {
  FileHiveEntity convertToFileHiveEntity() {
    return FileHiveEntity()
      ..fileId = fileId
      ..fileUrl = fileUrl
      ..createdAt = createdAt
      ..updatedAt = updatedAt;
  }
}
