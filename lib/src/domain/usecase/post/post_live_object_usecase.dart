import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/core/enum/tombstone_type.dart';
import 'package:amity_sdk/src/core/service_locator/service_locator.dart';
import 'package:amity_sdk/src/core/usercase/live_object_usecase.dart';
import 'package:amity_sdk/src/data/data_source/data_source.dart';
import 'package:amity_sdk/src/domain/composer_usecase/post_composer_usecase.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/domain/repo/amity_object_repository.dart';

class PostLiveObjectUseCase extends LiveObjectUseCase<PostHiveEntity , AmityPost>{
  
  @override
  AmityPost? composeModel(AmityPost model)  {
    serviceLocator<PostComposerUsecase>().get(model).then((value){
      return value;
    });
    
  }

  @override
  AmityObjectRepository<PostHiveEntity, AmityPost> createRepository() {
     return serviceLocator<PostRepo>() as AmityObjectRepository<PostHiveEntity, AmityPost>;
  }

  @override
  TombstoneModelType tombstoneModelType() {
    return TombstoneModelType.POST;
  }

}