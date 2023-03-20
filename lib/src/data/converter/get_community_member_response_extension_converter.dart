import 'package:amity_sdk/src/data/data.dart';

extension GetCommunityMembersResponseExtensionConverter
    on GetCommunityMembersResponse {
  /// Utils Method to save the Communiyt Member Response to Db
  Future saveToDb<T>(DbAdapterRepo dbRepo) async {
    //Convert to File Hive Entity
    //we have save the file first, since every object depends on file
    List<FileHiveEntity> fileHiveEntities =
        files.map((e) => e.convertToFileHiveEntity()).toList();

    //Convert to Community Hive Entity
    List<CommunityHiveEntity> communityHiveEntities =
        communities.map((e) => e.convertToCommunityHiveEntity()).toList();

    //Convert to User Hive Entity
    List<UserHiveEntity> userHiveEntities =
        users.map((e) => e.convertToUserHiveEntity()).toList();

    //Convert to Community Member Hive Entity
    List<CommnityMemberHiveEntity> communityMemberHiveEntities = communityUsers
        .map((e) => e.convertToCommnityMemberHiveEntity())
        .toList();

    //Save the File Entity
    for (var e in fileHiveEntities) {
      await dbRepo.fileDbAdapter.saveFileEntity(e);
    }

    //Save the Community Entity
    for (var e in communityHiveEntities) {
      await dbRepo.communityDbAdapter.saveCommunityEntity(e);
    }

    //Save the User Entity
    for (var e in userHiveEntities) {
      await dbRepo.userDbAdapter.saveUserEntity(e);
    }

    //Save the Community Member Entity
    for (var e in communityMemberHiveEntities) {
      await dbRepo.communityMemberDbAdapter.saveCommunityMemberEntity(e);
    }

    // FIXME: right logic for type checking
    if (T.toString() == 'AmityCommunity') {
      return communityHiveEntities
          .map((e) => e.convertToAmityCommunity())
          .toList();
    }

    // FIXME: right logic for type checking
    if (T.toString() == 'AmityCommunityMember') {
      return communityMemberHiveEntities
          .map((e) => e.convertToAmityCommunityMember())
          .toList();
    }
  }
}
