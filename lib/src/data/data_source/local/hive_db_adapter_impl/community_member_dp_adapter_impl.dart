import 'package:amity_sdk/src/core/enum/amity_membership_sort_option.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/data/data_source/local/db_adapter/community_member_db_adapter.dart';
import 'package:amity_sdk/src/data/data_source/local/hive_entity/community_member_hive_entity_14.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CommunityMemberDbAdapterImpl extends CommunityMemberDbAdapter {
  final DBClient dbClient;
  CommunityMemberDbAdapterImpl({required this.dbClient});
  late Box box;

  Future<CommunityMemberDbAdapterImpl> init() async {
    Hive.registerAdapter(CommnityMemberHiveEntityAdapter(), override: true);
    box = await Hive.openBox<CommnityMemberHiveEntity>('community_member_db');
    return this;
  }

  @override
  Future deleteCommunityMemberEntity(CommnityMemberHiveEntity entity) async {
    await box.delete(entity.id);
  }

  @override
  CommnityMemberHiveEntity getCommunityMemberEntities(
      String communityId,
      List<String> roles,
      List<String> memberships,
      AmityMembershipSortOption sortOption) {
    // TODO: implement getCommunityMemberEntities
    throw UnimplementedError();
  }

  

  @override
  CommnityMemberHiveEntity getCommunityMemberEntity(String id) {
    return box.get(id);
  }

  @override
  Stream<CommnityMemberHiveEntity> listenCommnunityMemberEntity(String id) {
    return box.watch(key: id).map((event) => event.value);
  }

  @override
  Future saveCommunityMemberEntity(CommnityMemberHiveEntity entity) async {
    await box.put(entity.id, entity);
  }
}
