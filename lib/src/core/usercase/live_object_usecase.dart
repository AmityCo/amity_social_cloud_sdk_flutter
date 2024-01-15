import 'dart:async';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/enum/amity_error.dart';
import 'package:amity_sdk/src/data/data_source/local/local.dart';
import 'package:amity_sdk/src/domain/repo/amity_object_repository.dart';
import 'package:amity_sdk/src/domain/repo/tombstone_repo.dart';

abstract class LiveObjectUseCase<Entity extends EkoObject, PublicModel> {
  TombstoneHiveEntity _nullTombstone = TombstoneHiveEntity()
    ..objectId = "NULL_TOMBSTONE";

  AmityObjectRepository<Entity, PublicModel> createRepository();

  PublicModel? composeModel(PublicModel model);

  TombstoneModelType tombstoneModelType();

  Stream<PublicModel> execute(String objectId) {
    final controller = StreamController<PublicModel>();
    bool verified = verifyObjectTombstone(objectId);
    if (verified) {
      retrieveLiveObject(objectId).listen((event) {
        controller.add(event);
      });
      return controller.stream;
    } else {
      throw AmityException(message: "", code: AmityError.ITEM_NOT_FOUND.code);
    }
  }

  Stream<PublicModel> retrieveLiveObject(String objectId) {
    final controller = StreamController<PublicModel>();
    var obtainObject = createRepository().obtain(objectId);

    obtainObject.then(
      (value) {
        createRepository().observe(objectId).stream.listen((event) {
          var compose = composeModel(event);
          if (compose != null) {
            controller.add(compose);
          } else {
            controller.add(event);
          }
        });
      },
    ).onError((error, stackTrace) {
      serviceLocator<TombstoneRepository>().saveTombstone(
          objectId: objectId,
          tombstoneModelType: tombstoneModelType(),
          error: AmityError.ITEM_NOT_FOUND);
    });

    return controller.stream;
  }

  bool verifyObjectTombstone(String objectId) {
    bool isValid = true;
    TombstoneHiveEntity? tombStone = serviceLocator<TombstoneRepository>()
        .getTombstone(objectId, tombstoneModelType());
    if (tombStone != null) {
      if(tombStone.objectId == _nullTombstone.objectId){
        return true;
      }
      bool isExpired = tombStone.getExpiresAt()!.isBefore(DateTime.now()) == true;
      isValid = isExpired;
    } else {
      isValid = true;
    }
    return isValid;
  }
}
