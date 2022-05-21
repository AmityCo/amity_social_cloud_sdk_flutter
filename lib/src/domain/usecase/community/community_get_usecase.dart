import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class CommunityGetUseCase extends UseCase<AmityCommunity, String> {
  final CommunityRepo communityRepo;
  final CommunityComposerUsecase communityComposerUsecase;

  CommunityGetUseCase(
      {required this.communityRepo, required this.communityComposerUsecase});
  @override
  Future<AmityCommunity> get(String params) async {
    final amityCommunity = await communityRepo.getCommunity(params);
    final amityCommunityComposed =
        await communityComposerUsecase.get(amityCommunity);
    return amityCommunityComposed;
  }

  @override
  Stream<AmityCommunity> listen(String params) {
    // TODO: implement listen
    throw UnimplementedError();
  }
}
