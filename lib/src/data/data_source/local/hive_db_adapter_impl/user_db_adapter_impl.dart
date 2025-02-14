import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:collection/collection.dart';
import 'package:hive/hive.dart';

class UserDbAdapterImpl extends UserDbAdapter {
  final DBClient dbClient;

  UserDbAdapterImpl({required this.dbClient});
  late Box<UserHiveEntity> box;
  Future<UserDbAdapterImpl> init() async {
    Hive.registerAdapter(UserHiveEntityAdapter(), override: true);
    box = await Hive.openBox<UserHiveEntity>('user_db');
    return this;
  }

  @override
  UserHiveEntity getUserEntity(String userId) {
    return box.get(userId)!;
  }

  @override
  UserHiveEntity? getUserEntityIfPresent(String userId) {
    return box.get(userId);
  }

  @override
  Future saveUserEntity(UserHiveEntity entity) async {
    await box.put(entity.userId, entity);
  }

  @override
  Future saveUserEntities(List<UserHiveEntity> entities) async {
    final users = {for (var e in entities) e.userId: e};
    await box.putAll(users);
  }

  @override
  Stream<UserHiveEntity> listenEntity(String userId) {
    return box.watch(key: userId).map((event) => event.value);
  }

  @override
  List<UserHiveEntity> getUsers() {
    return box.values.toList();
  }

  @override
  Stream<List<UserHiveEntity>> listenUserEntities(
      RequestBuilder<UsersRequest> request) {
    return box
        .watch()
        .map((event) => box.values.where((user) => user != null).toList())
        .distinct((a, b) => ListEquality().equals(a, b));
  }

  @override
  List<UserHiveEntity> getUserEntities(RequestBuilder<UsersRequest> request) {
    return box.values.toList();
  }
}
