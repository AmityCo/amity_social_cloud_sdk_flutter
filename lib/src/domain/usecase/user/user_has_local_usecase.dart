import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class UserHasLocalUsecase extends SynchronousUseCase<bool, String> {
  final UserRepo userRepo;
  // final PostComposerUsecase messageComposerUsecase;
  UserHasLocalUsecase({required this.userRepo});

  @override
  bool get(String params) {
    return userRepo.hasLocalUser(params);
  }
}
