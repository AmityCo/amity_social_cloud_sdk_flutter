import 'package:amity_sdk/domain/model/amity_user.dart';
import 'package:amity_sdk/domain/repo/user_repo.dart';

class GetUserByIdUseCase {
  GetUserByIdUseCase({required this.userRepo});
  final UserRepo userRepo;
  Future<AmityUser> callRepo(String userId) {
    throw UnimplementedError();
  }
}
