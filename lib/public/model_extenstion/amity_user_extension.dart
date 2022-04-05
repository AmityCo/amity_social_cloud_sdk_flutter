import 'package:amity_sdk/lib.dart';

extension AmityUserExtenstion on AmityUser {
  UserFeedQueryBuilder getFeed() {
    return UserFeedQueryBuilder(serviceLocator(), userId!);
  }
}
