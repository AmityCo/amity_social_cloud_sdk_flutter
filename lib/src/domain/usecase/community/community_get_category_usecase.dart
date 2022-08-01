import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class CommunityGetCategoryUsecase extends UseCase<
    PageListData<AmityCommunityCategory, String>, OptionsRequest> {
  final CommunityRepo communityRepo;
  final CommunityComposerUsecase communityComposerUsecase;

  CommunityGetCategoryUsecase(
      {required this.communityRepo, required this.communityComposerUsecase});

  @override
  Future<PageListData<AmityCommunityCategory, String>> get(
      OptionsRequest params) async {
    // final amityCommunity = await communityRepo.createCommunity(params);
    // final amityCreatedCommunity =
    //     await communityComposerUsecase.get(amityCommunity);
    // return amityCreatedCommunity;
    // TODO: implement listen
    throw UnimplementedError();
  }

  @override
  Stream<PageListData<AmityCommunityCategory, String>> listen(
      OptionsRequest params) {
    // TODO: implement listen
    throw UnimplementedError();
  }
}
