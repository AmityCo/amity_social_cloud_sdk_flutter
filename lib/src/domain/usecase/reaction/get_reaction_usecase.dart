import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class GetReactionUsecase extends UseCase<
    PageListData<List<AmityReaction>, String>, GetReactionRequest> {
  final ReactionRepo reactionRepo;
  final UserRepo userRepo;

  GetReactionUsecase({required this.reactionRepo, required this.userRepo});

  @override
  Future<PageListData<List<AmityReaction>, String>> get(
      GetReactionRequest params) async {
    final data = await reactionRepo.getReaction(params);

    final composedData =
        await Stream.fromIterable(data.data).asyncMap((event) async {
      final user = await userRepo.getUserById(event.userId!);
      event.userDisplayName = user.displayName!;
      return event;
    }).toList();

    return data.withItem1(composedData);
  }

  @override
  Stream<PageListData<List<AmityReaction>, String>> listen(
      GetReactionRequest params) {
    // TODO: implement listen
    throw UnimplementedError();
  }
}
