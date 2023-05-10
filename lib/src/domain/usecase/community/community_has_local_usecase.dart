import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class CommunityHasLocalUsecase extends SynchronousUseCase<bool, String> {
  final CommunityRepo communityRepo;
  // final CommunityComposerUsecase messageComposerUsecase;
  CommunityHasLocalUsecase({required this.communityRepo});

  @override
  bool get(String params) {
    return communityRepo.hasLocalCommunity(params);
  }
}
