import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/domain/usecase/post/post_live_object_usecase.dart';

class PostGetLiveObject{

  Stream<AmityPost> getPost(String postId){
    return PostLiveObjectUseCase().execute(postId);
  }
}