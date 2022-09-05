import 'package:amity_sdk/src/data/data_source/local/hive_entity/message_data_hive_entity_19.dart';
import 'package:amity_sdk/src/data/response/response.dart';

/// [MessageDataResponseExtensionConverter]
extension MessageDataResponseExtensionConverter on MessageDataResponse {
  /// Convert to message data entity
  MessageDataHiveEntity convertToMesageDataHiveEntity() {
    return MessageDataHiveEntity()
      ..text = text
      ..fileId = fileId
      ..caption = caption;
  }
}
