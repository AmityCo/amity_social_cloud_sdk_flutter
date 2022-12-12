import 'package:amity_sdk/src/core/usercase/usecase.dart';
import 'package:amity_sdk/src/domain/composer_usecase/user_compose_usecase.dart';
import 'package:amity_sdk/src/domain/model/amity_user.dart';
import 'package:amity_sdk/src/domain/repo/user_repo.dart';

class UserFlagUsecase extends UseCase<AmityUser, String> {
  UserFlagUsecase({required this.userRepo, required this.userComposerUsecase});
  final UserRepo userRepo;
  final UserComposerUsecase userComposerUsecase;

  @override
  Future<AmityUser> get(String params) async {
    //1. Get the public model (AmityUser) from data layer
    //2. Use the composer usecase to compose the public model (fill the detail)

    final amityUser = await userRepo.flag(params);
    final amityComposedUser = await userComposerUsecase.get(amityUser);
    return amityComposedUser;
  }
}
