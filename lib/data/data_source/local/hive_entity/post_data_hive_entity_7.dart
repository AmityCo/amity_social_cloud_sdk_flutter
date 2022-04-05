import 'package:hive_flutter/hive_flutter.dart';

part 'post_data_hive_entity_7.g.dart';

@HiveType(typeId: 7)
class PostChildDataHiveEntity {
  String? text;
  String? fileId;
  String? thumbnailFileId;
  Map<String, String>? videoFileId;
  String? streamId;
}
