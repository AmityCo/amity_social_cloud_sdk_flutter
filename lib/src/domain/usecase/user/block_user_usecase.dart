import 'package:amity_sdk/src/core/usercase/usecase.dart';
import 'package:amity_sdk/src/domain/repo/user_repo.dart';

class UserBlockUsecase extends UseCase<dynamic, String> {
  UserBlockUsecase({required this.userRepo});
  final UserRepo userRepo;

  @override
  Future<dynamic> get(String params) async {
    return userRepo.block(params);
  }
}
