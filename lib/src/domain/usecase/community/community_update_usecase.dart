import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class CommunityUpdateUseCase
    extends UseCase<AmityCommunity, CreateCommunityRequest> {
  final CommunityRepo communityRepo;
  final CommunityComposerUsecase communityComposerUsecase;

  CommunityUpdateUseCase(
      {required this.communityRepo, required this.communityComposerUsecase});
  @override
  Future<AmityCommunity> get(CreateCommunityRequest params) async {
    final amityCommunity = await communityRepo.updateCommunity(params);
    final amityCommunityComposed =
        await communityComposerUsecase.get(amityCommunity);
    return amityCommunityComposed;
  }
}
