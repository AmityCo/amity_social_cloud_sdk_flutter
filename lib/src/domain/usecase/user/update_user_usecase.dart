import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class UpdateUserUsecase extends UseCase<AmityUser, UpdateUserRequest> {
  UpdateUserUsecase(
      {required this.userRepo, required this.userComposerUsecase});
  final UserRepo userRepo;
  final UserComposerUsecase userComposerUsecase;

  @override
  Future<AmityUser> get(UpdateUserRequest params) async {
    //1. Get the public model (AmityUser) from data layer
    //2. Use the composer usecase to compose the public model (fill the detail)

    final amityUser = await userRepo.updateUser(params);
    final amityComposedUser = await userComposerUsecase.get(amityUser.first);
    return amityComposedUser;
  }
}
