import 'package:amity_sdk/src/data/data_source/data_source.dart';
import 'package:collection/collection.dart';

abstract class BaseAdapter<EntityType extends EkoObject> {
  List<EntityType> getByIdsNow(List<String> ids) {
    return List.empty(growable: true);
  }

  Duration getExpiration() {
    return Duration(minutes: 1);
  }


  Future insert(List<EntityType> objects);



  void save(List<EntityType> freshList) {
    List<EntityType> fromNetwork = freshList;
    List<String> idsFromNetwork = List.empty(growable: true);
    fromNetwork.mapIndexed((index, element) {
      idsFromNetwork.add(element.getId()!!);
    });
    List<EntityType> onDisk = getByIdsNow(idsFromNetwork);

    Map<String, EntityType> onDiskMap = {};
    onDisk.mapIndexed((index, element) {
      onDiskMap[element.getId()!!] = element;
    });
    List<EntityType> freshObjects = List.empty(growable: true);
    List<EntityType> changedObjects = List.empty(growable: true);

    fromNetwork.forEachIndexed((index, objectFromNetwork) {
      String id = objectFromNetwork.getId()!!;
      EntityType objectOnDisk = onDiskMap[id]!!;
      DateTime expirationDateTime = DateTime.now().add(getExpiration());
      if (!onDiskMap.containsKey(id)) {
        freshObjects.add(objectFromNetwork..setExpiresAt(expirationDateTime));
      } else if (objectFromNetwork.getUpdatedAt() != null &&
          // add new.updated >= old.updated
          (objectFromNetwork
                  .getUpdatedAt()!
                  .isAfter(objectOnDisk.getUpdatedAt()!) ||
              objectFromNetwork
                  .getUpdatedAt()!
                  .isAtSameMomentAs(objectOnDisk.getUpdatedAt()!))) {
        EntityType changedObject = objectFromNetwork
          ..setExpiresAt(expirationDateTime);
        changedObjects.add(changedObject);
      }
    });
    if (freshObjects.isNotEmpty) {
      insert(changedObjects);
    }
    if (changedObjects.isNotEmpty) {
      insert(changedObjects);
    }
  }
}
