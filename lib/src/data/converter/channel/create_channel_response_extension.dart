import 'package:amity_sdk/src/data/data.dart';

/// [CreateChannelResponseExtension]
extension CreateChannelResponseExtension on CreateChannelResponse {
  /// Utils Method to save the Post Response to Db
  Future saveToDb<T>(DbAdapterRepo dbRepo) async {
    //Convert to File Hive Entity

    //we have save the file first, since every object depends on file
    List<FileHiveEntity> fileHiveEntities =
        files.map((e) => e.convertToFileHiveEntity()).toList();

    //Convert to User Hive Entity
    List<UserHiveEntity> userHiveEntities =
        users.map((e) => e.convertToUserHiveEntity()).toList();

    //Conver Channel to Channel Hive Entity
    List<ChannelHiveEntity> channelHiveEntities =
        channels.map((e) => e.convertToChannelHiveEntity()).toList();

    //Conver Channel User to Channel User Hive Entity
    List<ChannelUserHiveEntity> channelUserHiveEntities =
        channelUsers.map((e) => e.convertToChannelUserHiveEntity()).toList();

    //Save the File Entity
    for (var e in fileHiveEntities) {
      await dbRepo.fileDbAdapter.saveFileEntity(e);
    }

    //Save the community Category
    for (var e in userHiveEntities) {
      await dbRepo.userDbAdapter.saveUserEntity(e);
    }

    //Save the Channel Hive
    for (var e in channelHiveEntities) {
      await dbRepo.channelDbAdapter.saveEntity(e);
    }

    //Save the Channel User Hive
    for (var e in channelUserHiveEntities) {
      await dbRepo.channelUserDbAdapter.saveEntity(e);
    }

    // FIXME: right logic for type checking
    if (T.toString() == 'AmityChannel') {
      return channelHiveEntities.map((e) => e.convertToAmityChannel()).toList();
    }
  }
}
