import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class CommunityGetCategoryUsecase extends UseCase<AmityCommunityCategory , String>{
  
  final CommunityCategoryRepo communityCategoryRepo;
  final CommunityCategoryComposerUsecase communityCategoryComposerUsecase;

  CommunityGetCategoryUsecase({required this.communityCategoryRepo, required this.communityCategoryComposerUsecase});
  
  @override
  Future<AmityCommunityCategory> get(String params) async {
    final amityCommunityCategory = await communityCategoryRepo.getCommunityCategory(params);
    final amityComposedCommunityCategory = await communityCategoryComposerUsecase.get(amityCommunityCategory);
    return amityComposedCommunityCategory;
  }

}