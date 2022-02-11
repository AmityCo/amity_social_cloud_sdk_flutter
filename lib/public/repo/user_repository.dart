import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/domain/usecase/get_all_user_usecase.dart';
import 'package:amity_sdk/public/public.dart';
import 'package:amity_sdk/public/query_builder/amity_all_user_query_builder.dart';
import 'package:amity_sdk/public/repo/amity_user_flag_repository.dart';
import 'package:amity_sdk/public/repo/amity_user_relationships_repository.dart';

class UserRepository {
  AmityAllUserQueryBuilder getUsers() {
    return AmityAllUserQueryBuilder(
        useCase: serviceLocator<GetAllUserUseCase>());
  }

  AmityAllUserQueryBuilder searchUserByDisplayName(String keyboard) {
    return AmityAllUserQueryBuilder(
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
