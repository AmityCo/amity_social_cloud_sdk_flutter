import 'package:hive/hive.dart';

part 'file_hive_entity_4.g.dart';

@HiveType(typeId: 4)
class FileHiveEntity {
  String? fileId;
  String? fileUrl;
  String? type;
  DateTime? createdAt;
  DateTime? updatedAt;
}
