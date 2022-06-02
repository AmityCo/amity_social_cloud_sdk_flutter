import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class CommunityGetQueryUseCase
    extends UseCase<Tuple2<List<AmityCommunity>, String>, GetCommunityRequest> {
  final CommunityRepo communityRepo;
  final CommunityComposerUsecase communityComposerUsecase;

  CommunityGetQueryUseCase(
      {required this.communityRepo, required this.communityComposerUsecase});
  @override
  Future<Tuple2<List<AmityCommunity>, String>> get(
      GetCommunityRequest params) async {
    final amityCommunities = await communityRepo.getCommunityQuery(params);
    final amityComposedCommunity =
        await Stream.fromIterable(amityCommunities.item1)
            .asyncMap((event) => communityComposerUsecase.get(event))
            .toList();
    return amityCommunities.withItem1(amityComposedCommunity);
  }

  @override
  Stream<Tuple2<List<AmityCommunity>, String>> listen(
      GetCommunityRequest params) {
    // TODO: implement listen
    throw UnimplementedError();
  }
}
