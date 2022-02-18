import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/domain/domain.dart';

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
