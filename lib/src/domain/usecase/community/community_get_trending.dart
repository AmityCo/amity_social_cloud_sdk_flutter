import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class CommunityGetTrendingUseCase
    extends UseCase<List<AmityCommunity>, OptionsRequest> {
  final CommunityRepo communityRepo;
  final CommunityComposerUsecase communityComposerUsecase;

  CommunityGetTrendingUseCase(
      {required this.communityRepo, required this.communityComposerUsecase});
  @override
  Future<List<AmityCommunity>> get(OptionsRequest params) async {
    final amityCommunities =
        await communityRepo.getTopTrendingCommunity(params);
    final amityComposedCommunity = await Stream.fromIterable(amityCommunities)
        .asyncMap((event) => communityComposerUsecase.get(event))
        .toList();
    return amityComposedCommunity;
  }

  @override
  Stream<List<AmityCommunity>> listen(OptionsRequest params) {
    // TODO: implement listen
    throw UnimplementedError();
  }
}
