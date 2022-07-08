import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/public/public.dart';

/// User Repository
class UserRepository {
  /// get the user query builder
  AmityAllUserQueryBuilder getUsers() {
    return AmityAllUserQueryBuilder(
        useCase: serviceLocator<GetAllUserUseCase>());
  }

  /// Search the user by their display name
  AmityUserSearchDisplayNameQueryBuilder searchUserByDisplayName(
      String keyboard) {
    return AmityUserSearchDisplayNameQueryBuilder(
        useCase: serviceLocator<GetAllUserUseCase>(), keyword: keyboard);
  }

  /// get the user with userId
  Future<AmityUser> getUser(String userId) {
    return serviceLocator<GetUserByIdUseCase>().get(userId);
  }

  /// API to update the user
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
}
