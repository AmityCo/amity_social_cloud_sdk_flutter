import 'package:hive/hive.dart';

part 'file_hive_entity_4.g.dart';

@HiveType(typeId: 4)

/// [FileHiveEntity]
class FileHiveEntity {
  /// File Doc ID
  String? fileId;

  /// Remote File Url
  String? fileUrl;

  /// Local File path for preview
  String? filePath;

  String? type;

  DateTime? createdAt;

  DateTime? updatedAt;

  //Attribute
  String? name;
  String? ext;
  String? size;
  String? mimeType;

  //Metadata
  int? height;
  int? width;
  bool? isFull;
}
