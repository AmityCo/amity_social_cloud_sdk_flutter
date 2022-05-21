import 'dart:async';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/model/api_request/get_community_members_request.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/data/data_source/local/db_adapter/community_member_db_adapter.dart';
import 'package:amity_sdk/src/data/data_source/local/db_adapter/community_member_paging_db_adapter.dart';
import 'package:amity_sdk/src/data/data_source/local/hive_entity/community_member_hive_entity_14.dart';
import 'package:amity_sdk/src/data/data_source/remote/api_interface/community_member_api_interface.dart';
import 'package:amity_sdk/src/data/response/get_community_members_response.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/domain/repo/community_member_repo.dart';

class CommunityMemberRepoImpl extends CommunityMemberRepo {
  final CommunityMemmberApiInterface communityMemmberApiInterface;
  final CommunityMemberPagingDbAdapter communityMemberPagingDbAdapter;
  final CommunityMemberDbAdapter communityMemberDbAdapter;
  final CommunityDbAdapter communityDbAdapter;
  final UserDbAdapter userDbAdapter;
  final FileDbAdapter fileDbAdapter;

  CommunityMemberRepoImpl(
      {required this.communityMemmberApiInterface,
      required this.communityMemberPagingDbAdapter,
      required this.communityMemberDbAdapter,
      required this.communityDbAdapter,
      required this.userDbAdapter,
      required this.fileDbAdapter});

  @override
  Future<Tuple2<List<AmityCommunityMember>, String>> queryMembers(
      GetCommunityMembersRequest request) async {
    final data =
        await communityMemmberApiInterface.getCommunityMembers(request);

    //Save members sequence in to feed db
    await communityMemberPagingDbAdapter.updateCommunityMemmberCollection(
        data.convertToCommunityMemberPagingHiveEntity());
    final amityCommunityMembers = await _saveDataToDb(data);
    return Tuple2(amityCommunityMembers, data.paging!.next ?? '');
  }

  Future<List<AmityCommunityMember>> _saveDataToDb(
      GetCommunityMembersResponse data) async {
    //Convert to File Hive Entity
    //we have save the file first, since every object depends on file
    List<FileHiveEntity> fileHiveEntities =
        data.files.map((e) => e.convertToFileHiveEntity()).toList();

    //Convert to Community Hive Entity
    List<CommunityHiveEntity> communityHiveEntities =
        data.communities.map((e) => e.convertToCommunityHiveEntity()).toList();

    //Convert to User Hive Entity
    List<UserHiveEntity> userHiveEntities =
        data.users.map((e) => e.convertToUserHiveEntity()).toList();

    //Convert to Community Member Hive Entity
    List<CommnityMemberHiveEntity> communityMemberHiveEntities = data
        .communityUsers
        .map((e) => e.convertToCommnityMemberHiveEntity())
        .toList();

    //Save the File Entity
    for (var e in fileHiveEntities) {
      await fileDbAdapter.saveFileEntity(e);
    }

    //Save the Community Entity
    for (var e in communityHiveEntities) {
      await communityDbAdapter.saveCommunityEntity(e);
    }

    //Save the User Entity
    for (var e in userHiveEntities) {
      await userDbAdapter.saveUserEntity(e);
    }

    //Save the Community Member Entity
    for (var e in communityMemberHiveEntities) {
      await communityMemberDbAdapter.saveCommunityMemberEntity(e);
    }

    return communityMemberHiveEntities
        .map((e) => e.convertToAmityCommunityMember())
        .toList();
  }
}
