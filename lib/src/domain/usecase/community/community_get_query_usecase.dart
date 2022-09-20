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
            .asyncMap<AmityCommunity>(
                (event) async => await communityComposerUsecase.get(event))
            .toList();
    return amityCommunities.withItem1(amityComposedCommunity);
  }
}
