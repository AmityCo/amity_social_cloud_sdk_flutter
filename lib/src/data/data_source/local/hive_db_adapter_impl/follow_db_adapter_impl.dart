import 'package:amity_sdk/src/core/model/api_request/follow_request.dart';
import 'package:amity_sdk/src/core/utils/live_collection.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:hive/hive.dart';

class FollowDbAdapterImpl extends FollowDbAdapter {
  final DBClient dbClient;

  FollowDbAdapterImpl({required this.dbClient});
  late Box<FollowHiveEntity> box;
  Future<FollowDbAdapter> init() async {
    Hive.registerAdapter(FollowHiveEntityAdapter(), override: true);
    box = await Hive.openBox<FollowHiveEntity>('follow_db');
    return this;
  }

  @override
  FollowHiveEntity? getFollowEntiry(String id) {
    return box.get(id);
  }

  @override
  Future saveFollowEntity(FollowHiveEntity entity) async {
    await box.put('${entity.sourceUserId}_${entity.targetUserId}', entity);
  }

  @override
  Stream<FollowHiveEntity> stream(String id) {
    return box.watch(key: id).map((event) => event.value);
  }

  @override
  Stream<List<FollowHiveEntity>> listenFollowEntities(
      RequestBuilder<FollowRequest> request) {
    return box.watch().map((event) => box.values
        .where((follow) => follow.isMatchingFilter(request.call())
            //missing tags
            )
        .toList());
  }

  @override
  List<FollowHiveEntity> getFollowEntities(
      RequestBuilder<FollowRequest> request) {
    return box.values
        .where((follows) => follows.isMatchingFilter(request.call()))
        .toList();
  }
}
