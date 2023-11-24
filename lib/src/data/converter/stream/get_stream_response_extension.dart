import 'package:amity_sdk/src/data/converter/stream/stream_hive_extension_convertor.dart';
import 'package:amity_sdk/src/data/converter/stream/stream_response_extension_converter.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/data/data_source/local/hive_entity/stream_hive_entity_22.dart';
import 'package:amity_sdk/src/data/response/get_streams_response.dart';

extension GetStreamResponseExtension on GetStreamsResponse {
  Future saveToDb<T>(DbAdapterRepo dbRepo) async {
    List<FileHiveEntity> fileHiveEntities =
        files.map((e) => e.convertToFileHiveEntity()).toList();

    List<UserHiveEntity> userHiveEntities =
        users.map((e) => e.convertToUserHiveEntity()).toList();

    List<StreamHiveEntity> streamHiveEntities =
        streams.map((e) => e.convertToStreamHiveEntity()).toList();

    for (var e in fileHiveEntities) {
      await dbRepo.fileDbAdapter.saveFileEntity(e);
    }

    for (var e in userHiveEntities) {
      await dbRepo.userDbAdapter.saveUserEntity(e);
    }

    for (var e in streamHiveEntities) {
      await dbRepo.streamDbAdapter.saveStreamEntity(e);
    }

    if (T.toString() == 'AmityStream') {
      return streamHiveEntities
          .map((e) =>  e.convertToAmityStream())
          .toList();
    }
  }
}