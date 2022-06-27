import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class CommunityGetQueryUseCase extends UseCase<
    PageListData<List<AmityCommunity>, String>, GetCommunityRequest> {
  final CommunityRepo communityRepo;
  final CommunityComposerUsecase communityComposerUsecase;

  CommunityGetQueryUseCase(
      {required this.communityRepo, required this.communityComposerUsecase});
  @override
  Future<PageListData<List<AmityCommunity>, String>> get(
      GetCommunityRequest params) async {
    final amityCommunities = await communityRepo.getCommunityQuery(params);
    final amityComposedCommunity =
        await Stream.fromIterable(amityCommunities.data)
            .asyncMap((event) => communityComposerUsecase.get(event))
            .toList();
    return amityCommunities.withItem1(amityComposedCommunity);
  }

  @override
  Stream<PageListData<List<AmityCommunity>, String>> listen(
      GetCommunityRequest params) {
    // TODO: implement listen
    throw UnimplementedError();
  }
}
