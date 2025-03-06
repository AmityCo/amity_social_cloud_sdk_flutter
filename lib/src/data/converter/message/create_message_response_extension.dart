import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/data/data.dart';

/// [CreateMessageResponseExtension]
extension CreateMessageResponseExtension on CreateMessageResponse {
  /// Utils Method to save the Post Response to Db
  Future saveToDb<T>(DbAdapterRepo dbRepo, {bool fromAddReactionEvent = false}) async {
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

    //Save Message Entity
    for (var e in messagesHiveEntities) {
      if (e.uniqueId != e.messageId) {
        dbRepo.messageDbAdapter.deleteMessageEntityByUniqueId(e.uniqueId!);
        e.uniqueId = e.messageId;
      }
      /// Save all message with sync state
      e.syncState = AmityMessageSyncState.SYNCED.value;
      if (fromAddReactionEvent && e.myReactions == null) {
          final entity = dbRepo.messageDbAdapter.getMessageEntity(e.messageId!);
          e.myReactions = entity?.myReactions;
      }
      await dbRepo.messageDbAdapter.saveMessageEntity(e);
    }

    // FIXME: right logic for type checking
    if (T.toString() == 'AmityMessage') {
      return messagesHiveEntities
          .map((e) => e.convertToAmityMessage())
          .toList();
    }
  }

  Future saveEventToDb<T>(DbAdapterRepo dbRepo, {bool fromAddReactionEvent = false}) async {
    await saveToDb<T>(dbRepo, fromAddReactionEvent: fromAddReactionEvent);
    await saveReactionFromEvent(dbRepo, users, reactor, AmityReactionReferenceType.MESSAGE);
  }
}
