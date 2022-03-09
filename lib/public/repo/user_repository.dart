import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/domain/domain.dart';
import 'package:amity_sdk/public/public.dart';
import 'package:amity_sdk/public/query_builder/amity_user_search_display_name_query_builder.dart';
import 'package:amity_sdk/public/repo/sub_set/sub_set.dart';

class UserRepository {
  AmityAllUserQueryBuilder getUsers() {
    return AmityAllUserQueryBuilder(
        useCase: serviceLocator<GetAllUserUseCase>());
  }

  AmityUserSearchDisplayNameQueryBuilder searchUserByDisplayName(
      String keyboard) {
    return AmityUserSearchDisplayNameQueryBuilder(
        useCase: serviceLocator<GetAllUserUseCase>(), keyword: keyboard);
  }

  Future<AmityUser> getUser(String userId) {
    return serviceLocator<GetUserByIdUseCase>().get(userId);
  }

  AmityUserFlagRepository report(String userId) {
    return AmityUserFlagRepository(userId: userId);
  }

  AmityUserRelationshipsRepository relationship() {
    return AmityUserRelationshipsRepository();
  }
}
