import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/enum/amity_membership_sorting_order.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:hive/hive.dart';

class CommunityMemberDbAdapterImpl extends CommunityMemberDbAdapter {
  final DBClient dbClient;
  CommunityMemberDbAdapterImpl({required this.dbClient});
  late Box<CommunityMemberHiveEntity> box;

  Future<CommunityMemberDbAdapterImpl> init() async {
    Hive.registerAdapter(CommunityMemberHiveEntityAdapter(), override: true);
    box = await Hive.openBox<CommunityMemberHiveEntity>('community_member_db');
    return this;
  }

  @override
  List<CommunityMemberHiveEntity> getCommunityMemberEntities(
      RequestBuilder<GetCommunityMembersRequest> request) {
        return box.values
        .where((entity) => entity.isMatchingFilter(request.call()))
        .toList();
  }

  @override
  Future saveCommunityMemberEntity(CommunityMemberHiveEntity entity, UserHiveEntity? userEntity) async {
    if (userEntity != null) {
      // Determine if the user is deleted from user entity
      entity.isDeleted = userEntity.isDeleted;
    } else {
      // If no user entity is found, and the cache from the db is exists, use cache.isDeleted value
      final cache = await box.get(entity.communityId! + entity.userId!);
      if (cache != null) {
        entity.isDeleted = cache.isDeleted;
      }
    }
    await box.put(entity.communityId! + entity.userId!, entity);
  }

  @override
  CommunityMemberHiveEntity? getCommunityMemberEntity(String id) {
    return box.get(id);
  }

  @override
  Future deleteCommunityMemberEntity(CommunityMemberHiveEntity entity) async {
    await box.delete(entity.communityId! + entity.userId!);
  }

  @override
  Stream<CommunityMemberHiveEntity> listenCommnunityMemberEntity(String id) {
    return box.watch(key: id).map((event) => event.value);
  }

  @override
  Stream<List<CommunityMemberHiveEntity>> listenCommnunityMemberEntities(RequestBuilder<GetCommunityMembersRequest> request) {
    return box.watch().map((event) => box.values
        .where((member) => member.isMatchingFilter(request.call()))
        .toList());
  }
}
