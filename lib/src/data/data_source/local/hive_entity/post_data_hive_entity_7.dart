import 'dart:convert';

import 'package:hive/hive.dart';

part 'post_data_hive_entity_7.g.dart';

/// Data Field for Post
@HiveType(typeId: 7)
class PostChildDataHiveEntity {
  /// Text
  String? text;

  /// File Id
  String? fileId;

  /// Thumbnail File Id for Video
  String? thumbnailFileId;

  /// Video  File Id
  Map<String, String>? videoFileId;

  /// Stream Id for Live Stream post
  String? streamId;

  /// Poll Id for Poll Post
  String? pollId;

  /// Change object to Map
  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'fileId': fileId,
      'thumbnailFileId': thumbnailFileId,
      'videoFileId': videoFileId,
      'streamId': streamId,
      'pollId': pollId,
    };
  }

  /// Convert Object to String json
  String toJson() => json.encode(toMap());
}
