import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/public/public.dart';

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

  UserUpdateQueryBuilder updateUser(String userId) {
    return UserUpdateQueryBuilder(serviceLocator<UpdateUserUsecase>(), userId);
  }

  AmityUserFlagRepository report(String userId) {
    return AmityUserFlagRepository(userId: userId);
  }

  AmityUserRelationshipsRepository relationship() {
    return AmityUserRelationshipsRepository();
  }
}
