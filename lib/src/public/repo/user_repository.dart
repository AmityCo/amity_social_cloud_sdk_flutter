import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/public/public.dart';
import 'package:amity_sdk/src/public/query_builder/user/amity_query_reach_user_builder.dart';

/// User Repository
class UserRepository {
  /* begin_public_function 
  id: user.query
  */
  /// get the user query builder
  AmityAllUserQueryBuilder getUsers() {
    return AmityAllUserQueryBuilder(useCase: serviceLocator<GetAllUserUseCase>());
  }
  /* end_public_function */

  /* begin_public_function 
  id: user.search
  */
  /// Search the user by their display name
  AmityUserSearchDisplayNameQueryBuilder searchUserByDisplayName(String keyword) {
    return AmityUserSearchDisplayNameQueryBuilder(useCase: serviceLocator<GetAllUserUseCase>(), keyword: keyword);
  }
  /* end_public_function */

  /* begin_public_function 
  id: user.get, user.get_by_ids
  */
  /// get the user with userId
  Future<AmityUser> getUser(String userId) {
    return serviceLocator<GetUserByIdUseCase>().get(userId);
  }
  /* end_public_function */

  UserUpdateQueryBuilder updateUser(String userId) {
    return UserUpdateQueryBuilder(serviceLocator<UpdateUserUsecase>(), userId);
  }

  /// Report the current user
  AmityUserFlagRepository report(String userId) {
    return AmityUserFlagRepository(userId: userId);
  }

  /// API to get relationship mapping with the user
  AmityUserRelationshipsRepository relationship() {
    return AmityUserRelationshipsRepository();
  }

  /// API to get blocked users
  AmityBlockUserQueryBuilder getBlockedUsers() {
    return AmityBlockUserQueryBuilder(useCase: serviceLocator());
  }


  /// API to get blocked users
  AmityQueryReachUserBuilder getViewedUsers({ required AmityViewedType viewedType , required String  viewedId}) {
    return AmityQueryReachUserBuilder(useCase: serviceLocator() , viewedType: viewedType , viewedId: viewedId);
  }
}
