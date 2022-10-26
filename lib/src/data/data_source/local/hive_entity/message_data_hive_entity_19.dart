import 'dart:convert';

import 'package:hive/hive.dart';

part 'message_data_hive_entity_19.g.dart';

/// Data Field for Post
@HiveType(typeId: 19)
class MessageDataHiveEntity {
  /// Text
  String? text;

  /// File Id
  String? fileId;

  /// Stream Id for Live Stream post
  String? caption;

  /// Change object to Map
  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'fileId': fileId,
      'caption': caption,
    };
  }

  /// Convert Object to String json
  String toJson() => json.encode(toMap());
}
