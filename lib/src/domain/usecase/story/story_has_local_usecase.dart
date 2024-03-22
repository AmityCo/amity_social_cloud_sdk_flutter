import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class StoryHasLocalUseCase extends SynchronousUseCase<bool, String> {
  final StoryRepo storyRepo;

  StoryHasLocalUseCase({ required  this.storyRepo});

  @override
  bool get(String params) {
    return storyRepo.hasLocalStory(params);
  }
}