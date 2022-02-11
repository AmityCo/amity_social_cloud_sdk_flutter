import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/public/repo/post_repository.dart';

class AmitySocialClient {
  static PostRepository newPostRepository() => serviceLocator<PostRepository>();
}
