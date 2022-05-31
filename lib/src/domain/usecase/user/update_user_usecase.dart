import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/model/api_request/update_user_request.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class UpdateUserUsecase extends UseCase<AmityUser, UpdateUserRequest> {
  UpdateUserUsecase(
      {required this.userRepo, required this.userComposerUsecase});
  final UserRepo userRepo;
  final UserComposerUsecase userComposerUsecase;

  @override
  Future<AmityUser> get(UpdateUserRequest request) async {
    //1. Get the public model (AmityUser) from data layer
    //2. Use the composer usecase to compose the public model (fill the detail)

    final amityUser = await userRepo.updateUser(request);
    final amityComposedUser = await userComposerUsecase.get(amityUser.first);
    return amityComposedUser;
  }

  @override
  Stream<AmityUser> listen(UpdateUserRequest request) {
    // TODO: implement listen
    throw UnimplementedError();
  }
}
