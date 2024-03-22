import 'package:amity_sdk/src/src.dart';
import 'package:hive/hive.dart';

part 'file_hive_entity_4.g.dart';

@HiveType(typeId: 4)

/// [FileHiveEntity]
class FileHiveEntity  extends EkoObject{
  /// File Doc ID
  String? fileId;

  /// Remote File Url
  String? fileUrl;

  /// Local File path for preview
  String? filePath;

  String? type;

  DateTime? createdAt;

  DateTime? updatedAt;

  Map<String, dynamic>? rawFile;

  //Attribute
  String? name;
  String? ext;
  String? size;
  String? mimeType;

  //Metadata
  int? height;
  int? width;
  bool? isFull;
  
  @override
  String? getId() {
    return fileId;
  }
}
