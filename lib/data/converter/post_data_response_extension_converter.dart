import 'package:amity_sdk/data/data_source/local/hive_entity/post_data_hive_entity_7.dart';
import 'package:amity_sdk/data/response/core_response/post_data_response.dart';

extension PostDataResponseExtension on PostDataResponse {
  PostChildDataHiveEntity convertToPostDataHiveEntity() {
    return PostChildDataHiveEntity()
      ..text = text
      ..fileId = fileId
      ..thumbnailFileId = thumbnailFileId
      ..streamId = streamId;
  }
}
