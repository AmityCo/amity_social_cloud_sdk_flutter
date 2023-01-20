import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class GetAllUserUseCase
    extends UseCase<PageListData<List<AmityUser>, String>, UsersRequest> {
  final UserRepo userRepo;
  final UserComposerUsecase userComposerUsecase;
  GetAllUserUseCase(
      {required this.userRepo, required this.userComposerUsecase});

  @override
  Future<PageListData<List<AmityUser>, String>> get(UsersRequest params) async {
    //1. Get the public model (AmityUser) from data layer
    //2. Use the composer usecase to compose the public model (fill the detail)

    final amityUsers = await userRepo.getUsers(params);
    final amityComposedUsers = await Stream.fromIterable(amityUsers.data)
        .asyncMap((event) async => await userComposerUsecase.get(event))
        .toList();
    return amityUsers.withItem1(amityComposedUsers);
  }
}
