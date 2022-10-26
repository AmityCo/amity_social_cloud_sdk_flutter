import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// [CommunityGetTrendingUseCase]
class CommunityGetTrendingUseCase
    extends UseCase<List<AmityCommunity>, OptionsRequest> {
  final CommunityRepo communityRepo;
  final CommunityComposerUsecase communityComposerUsecase;

  /// Init [CommunityGetTrendingUseCase]
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
}
