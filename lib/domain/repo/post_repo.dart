import 'package:amity_sdk/domain/model/amity_post.dart';

abstract class PostRepo {
  Future<AmityPost> getPostById(String postId);
}
