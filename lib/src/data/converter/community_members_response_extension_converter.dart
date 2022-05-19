import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/data/data_source/local/hive_entity/community_member_hive_entity_14.dart';
import 'package:amity_sdk/src/data/data_source/local/hive_entity/community_member_paging_hive_entity_15.dart';
import 'package:amity_sdk/src/data/response/get_community_members_response.dart';

extension CommunityMemmbersResponseExtension on GetCommunityMembersResponse {
  CommunityMemberPagingHiveEntity convertToCommunityMemberPagingHiveEntity() =>
      CommunityMemberPagingHiveEntity()
        ..id = '$hashCode'
        ..communityMemberIds = communityUsers.map((e) => e.userId).toList()
        ..nextToken = paging?.next;

  Future saveToDb(DbAdapterRepo dbRepo) async {
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
  }
}
