import 'package:amity_sdk/src/data/data_source/local/hive_entity/file_hive_entity_4.dart';
import 'package:amity_sdk/src/domain/model/amity_file/amity_file_properties.dart';

extension FileHiveEntityExtension on FileHiveEntity {
  AmityFileProperties convertToAmityFileProperties() {
    return AmityFileProperties()
      ..fileId = fileId
      ..fileUrl = fileUrl
      ..type = type
      ..createdAt = createdAt
      ..updatedAt = updatedAt
      //Attribute
      ..name = name
      ..ext = ext
      ..size = size
      ..mimeType = mimeType
      //Metadata
      ..height = height
      ..width = width
      ..isFull = isFull;
  }
}
