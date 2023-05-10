import 'package:amity_sdk/src/data/data.dart';

extension CreateCommunityResponseExtentionResponse on CreateCommunityResponse {
  /// Utils Method to save the Communiyt Response to Db
  Future saveToDb<T>(DbAdapterRepo dbRepo) async {
    //Convert to File Hive Entity
    //we have save the file first, since every object depends on file
    List<FileHiveEntity> fileHiveEntities =
        files.map((e) => e.convertToFileHiveEntity()).toList();

    //Convert to User Hive Entity
    List<UserHiveEntity> userHiveEntities =
        users.map((e) => e.convertToUserHiveEntity()).toList();

    //Conver to category hive entity
    List<CommunityCategoryHiveEntity> communityCategoryHiveEnties = categories
        .map((e) => e.convertToCommunityCategoryHiveEntity())
        .toList();

    //Conver to Feed hive entity
    List<CommunityFeedHiveEntity> communityFeedHiveEnties =
        feeds.map((e) => e.convertToCommunityFeedHiveEntity()).toList();

    //Conver to Feed hive entity
    List<CommunityHiveEntity> communityHiveEnties =
        communities.map((e) => e.convertToCommunityHiveEntity()).toList();

    //Convert to Community Member Hive Entity
    List<CommnityMemberHiveEntity> communityMemberHiveEntities = communityUsers
        .map((e) => e.convertToCommnityMemberHiveEntity())
        .toList();

    //Save the File Entity
    for (var e in fileHiveEntities) {
      await dbRepo.fileDbAdapter.saveFileEntity(e);
    }

    //Save the User Entity
    for (var e in userHiveEntities) {
      await dbRepo.userDbAdapter.saveUserEntity(e);
    }

    //Save the Community Category Entity
    for (var e in communityCategoryHiveEnties) {
      await dbRepo.communityCategoryDbAdapter.saveCommunityCategoryEntity(e);
    }

    //Save the Community Feed Entity
    for (var e in communityFeedHiveEnties) {
      await dbRepo.communityFeedDbAdapter.saveCommunityFeedEntity(e);
    }

    //Save the Community  Entity
    for (var e in communityHiveEnties) {
      await dbRepo.communityDbAdapter.saveCommunityEntity(e);
    }

    //Save the Community Member Entity
    for (var e in communityMemberHiveEntities) {
      await dbRepo.communityMemberDbAdapter.saveCommunityMemberEntity(e);
    }

    // FIXME: right logic for type checking
    if (T.toString() == 'AmityCommunity') {
      return communityHiveEnties
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
