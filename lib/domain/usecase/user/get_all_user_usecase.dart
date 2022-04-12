import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/domain/domain.dart';

class GetAllUserUseCase extends UseCase<List<AmityUser>, UsersRequest> {
  final UserRepo userRepo;
  final UserComposerUsecase userComposerUsecase;
  GetAllUserUseCase(
      {required this.userRepo, required this.userComposerUsecase});

  @override
  Future<List<AmityUser>> get(UsersRequest params) async {
    //1. Get the public model (AmityUser) from data layer
    //2. Use the composer usecase to compose the public model (fill the detail)

    final amityUsers = await userRepo.getUsers(params);
    final amityComposedUsers = Stream.fromIterable(amityUsers)
        .asyncMap((event) async => await userComposerUsecase.get(event))
        .toList();
    return amityComposedUsers;
  }

  @override
  Stream<List<AmityUser>> listen(UsersRequest params) {
    throw UnimplementedError();
  }
}
