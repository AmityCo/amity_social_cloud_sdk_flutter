import 'package:amity_sdk/core/model/api_request/users_request.dart';
import 'package:amity_sdk/core/usercase/usecase.dart';
import 'package:amity_sdk/public/public.dart';

class GetAllUserUseCase extends UseCase<List<AmityUser>, UsersRequest> {
  final UserRepo userRepo;

  GetAllUserUseCase({required this.userRepo});

  @override
  Future<List<AmityUser>> get(UsersRequest params) {
    return userRepo.getUsers(params);
  }

  @override
  Stream<List<AmityUser>> listen(UsersRequest params) {
    throw UnimplementedError();
  }
}
