import 'package:amity_sdk/src/data/data.dart';
import 'package:collection/collection.dart';
import 'package:hive/hive.dart';

class PagingIdDbAdapterImpl extends PagingIdDbAdapter {
  
  PagingIdDbAdapterImpl({required this.dbClient});
  final DBClient dbClient;
  late Box<PagingIdHiveEntity> box;
  Future<PagingIdDbAdapter> init() async {
    Hive.registerAdapter(PagingIdHiveEntityAdapter(), override: true);
    box = await Hive.openBox<PagingIdHiveEntity>('paging_id_db');
    return this;
  }
  
  @override
  Future savePagingIdEntity(PagingIdHiveEntity data) async {
    await box.put(data.getId(), data);
  }

  @override
  Future savePagingIdEntities(List<PagingIdHiveEntity> data) async {
    final pagingIds = { for (var e in data) e.getId() : e };
    await box.putAll(pagingIds);
  }
  
  @override
  List<PagingIdHiveEntity> getPagingIdEntities(int nonce, int hash) {
    return box.values
        .where((pagingId) => pagingId.hash == hash && pagingId.nonce == nonce)
        .sorted((a, b) => (a.position ?? 0).compareTo(a.position ?? 0))
        .toList();
  }

  @override
  Stream<List<PagingIdHiveEntity>> listenPagingIdEntities(int nonce, int hash) {
    return box.watch().map((event) => box.values
      .where((pagingId) => pagingId.hash == hash && pagingId.nonce == nonce)
      .sorted((a, b) => (a.position ?? 0).compareTo(a.position ?? 0))
      .toList())
      .distinct((previous, current) {
        return ListEquality().equals(previous, current);
      });
  }

  @override
  Future deletePagingIdByHash(int nonce, int hash) async {
    final pagingIds = box.values
      .where((pagingId) => pagingId.hash == hash && pagingId.nonce == nonce)
      .map((pagingId) => pagingId.getId())
      .toList();
    await box.deleteAll(pagingIds);
  }
}
