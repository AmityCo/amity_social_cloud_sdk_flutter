import 'package:amity_sdk/src/data/data_source/local/hive_entity/file_hive_entity_4.dart';
import 'package:amity_sdk/src/data/response/response.dart';

/// [FileResponse] extension
extension FileResponsseExtension on FileResponse {
  /// convert [FileResponse] to [FileHiveEntity]
  FileHiveEntity convertToFileHiveEntity() {
    var fileEntity = FileHiveEntity()
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
      ..height = attributes.metadata?.video?.height ?? attributes.metadata?.height
      ..width = attributes.metadata?.video?.width ?? attributes.metadata?.width
      ..isFull = attributes.metadata?.isFull
      ..rawFile = toJson();
    return fileEntity;
  }
}
