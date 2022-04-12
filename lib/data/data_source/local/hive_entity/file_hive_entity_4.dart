import 'package:hive/hive.dart';

part 'file_hive_entity_4.g.dart';

@HiveType(typeId: 4)
class FileHiveEntity {
  String? fileId;
  String? fileUrl;
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
