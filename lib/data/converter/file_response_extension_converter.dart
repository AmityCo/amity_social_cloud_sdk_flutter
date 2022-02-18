import 'package:amity_sdk/data/data_source/local/hive_entity/file_hive_entity_4.dart';
import 'package:amity_sdk/data/response/response.dart';

extension FileResponsseExtension on FileResponse {
  FileHiveEntity convertToFileHiveEntity() {
    return FileHiveEntity()
      ..fileId = fileId
      ..fileUrl = fileUrl
      ..createdAt = createdAt
      ..updatedAt = updatedAt;
  }
}
