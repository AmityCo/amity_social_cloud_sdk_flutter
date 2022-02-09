import 'package:amity_sdk/data/data.dart';

abstract class PublicPostApiInterface {
  Future<GetPostByIdResponse> getPostById(String postId);
}
