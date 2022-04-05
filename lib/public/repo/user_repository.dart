import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/domain/domain.dart';
import 'package:amity_sdk/public/public.dart';

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
