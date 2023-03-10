import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class PostHasLocalUsecase extends SynchronousUseCase<bool, String> {
  final PostRepo postRepo;
  // final PostComposerUsecase messageComposerUsecase;
  PostHasLocalUsecase({required this.postRepo});

  @override
  bool get(String params) {
    return postRepo.hasLocalPost(params);
  }
}
