import 'package:amity_sdk/src/data/data_source/local/hive_entity/file_hive_entity_4.dart';
import 'package:amity_sdk/src/data/response/response.dart';

extension FileResponsseExtension on FileResponse {
  FileHiveEntity convertToFileHiveEntity() {
    return FileHiveEntity()
      ..fileId = fileId
      ..fileUrl = fileUrl
      ..type = type
      ..createdAt = createdAt
      ..updatedAt = updatedAt
      //attribute
      ..name = attributes.name
      ..ext = attributes.ext
      ..mimeType = attributes.mimeType
      ..size = attributes.size
      //metadata
      ..height = attributes.metadata?.height
      ..width = attributes.metadata?.width
      ..isFull = attributes.metadata?.isFull;
  }
}
