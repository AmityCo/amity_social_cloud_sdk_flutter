import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/public/public.dart';

extension AmityUserExtenstion on AmityUser {
  UserFeedQueryBuilder getFeed() {
    return UserFeedQueryBuilder(serviceLocator(), userId!);
  }

  UserUpdateQueryBuilder update() {
    return UserUpdateQueryBuilder(serviceLocator<UpdateUserUsecase>(), userId!);
  }
}
