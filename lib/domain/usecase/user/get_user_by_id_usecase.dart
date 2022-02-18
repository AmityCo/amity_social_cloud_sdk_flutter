import 'package:amity_sdk/core/usercase/usecase.dart';
import 'package:amity_sdk/domain/model/amity_user.dart';
import 'package:amity_sdk/domain/repo/user_repo.dart';

class GetUserByIdUseCase extends UseCase<AmityUser, String> {
  GetUserByIdUseCase({required this.userRepo});
  final UserRepo userRepo;

  @override
  Future<AmityUser> get(String params) {
    return userRepo.getUserById(params);
  }

  @override
  Stream<AmityUser> listen(String params) {
    // TODO: implement listen
    throw UnimplementedError();
  }
}
