import 'package:amity_sdk/src/core/enum/amity_message_sync_state.dart';
import 'package:amity_sdk/src/data/data.dart';

/// [CreateMessageResponseExtension]
extension CreateMessageResponseExtension on CreateMessageResponse {
  /// Utils Method to save the Post Response to Db
  Future saveToDb<T>(DbAdapterRepo dbRepo) async {
    //Convert to File Hive Entity

    //we have save the file first, since every object depends on file
    List<FileHiveEntity> fileHiveEntities =
        files.map((e) => e.convertToFileHiveEntity()).toList();

    //Convert to User Hive Entity
    List<UserHiveEntity> userHiveEntities =
        users.map((e) => e.convertToUserHiveEntity()).toList();

    //Conver Message to Message Hive Entity
    List<MessageHiveEntity> messagesHiveEntities =
        messages.map((e) => e.convertToMesageHiveEntity()).toList();

    //Save the File Entity
    for (var e in fileHiveEntities) {
      await dbRepo.fileDbAdapter.saveFileEntity(e);
    }

    //Save the community Category
    for (var e in userHiveEntities) {
      await dbRepo.userDbAdapter.saveUserEntity(e);
    }

    //Save Post Entity
    for (var e in messagesHiveEntities) {
      /// Save all message with sync state
      e.syncState = AmityMessageSyncState.SYNCED;
      await dbRepo.messageDbAdapter.saveMessageEntity(e);
    }

    // FIXME: right logic for type checking
    if (T.toString() == 'AmityMessage') {
      return messagesHiveEntities
          .map((e) => e.convertToAmityMessage())
          .toList();
    }
  }
}
