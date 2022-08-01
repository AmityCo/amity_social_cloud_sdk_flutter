import 'package:amity_sdk/src/core/enum/amity_membership_sorting_order.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:hive/hive.dart';

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
  CommnityMemberHiveEntity getCommunityMemberEntities(
      String communityId,
      List<String> roles,
      List<String> memberships,
      AmityMembershipSortOption sortOption) {
    // TODO: implement getCommunityMemberEntities
    throw UnimplementedError();
  }

  @override
  Future saveCommunityMemberEntity(CommnityMemberHiveEntity entity) async {
    await box.put(entity.communityId! + entity.userId!, entity);
  }

  @override
  CommnityMemberHiveEntity getCommunityMemberEntity(String id) {
    return box.get(id);
  }

  @override
  Future deleteCommunityMemberEntity(CommnityMemberHiveEntity entity) async {
    await box.delete(entity.communityId! + entity.userId!);
  }

  @override
  Stream<CommnityMemberHiveEntity> listenCommnunityMemberEntity(String id) {
    return box.watch(key: id).map((event) => event.value);
  }
}
