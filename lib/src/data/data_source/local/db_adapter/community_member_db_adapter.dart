import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/enum/amity_membership_sorting_order.dart';
import 'package:amity_sdk/src/data/data_source/data_source.dart';

abstract class CommunityMemberDbAdapter {
  Future saveCommunityMemberEntity(CommunityMemberHiveEntity entity, UserHiveEntity? userEntity);
  CommunityMemberHiveEntity? getCommunityMemberEntity(String id);
  Future deleteCommunityMemberEntity(CommunityMemberHiveEntity entity);
  List<CommunityMemberHiveEntity> getCommunityMemberEntities(
      RequestBuilder<GetCommunityMembersRequest> request);
  Stream<CommunityMemberHiveEntity> listenCommnunityMemberEntity(String id);
  Stream<List<CommunityMemberHiveEntity>> listenCommnunityMemberEntities(RequestBuilder<GetCommunityMembersRequest> request);
}
