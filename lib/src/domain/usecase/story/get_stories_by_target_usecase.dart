import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/composer_usecase/story_composer_usercase.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class GetStoryByTargetUseCase extends UseCase<List<AmityStory> , GetStoriesByTragetRequest>{

  final StoryRepo storyRepo;
  final StoryComposerUseCase storyComposerUseCase;

  GetStoryByTargetUseCase({required this.storyRepo, required this.storyComposerUseCase});

  @override
  Future<List<AmityStory>> get(GetStoriesByTragetRequest params) async  {
    final amityStories = await storyRepo.getStories(params);
    List<AmityStory> composedStories = [];
    for (var element in amityStories) {
      composedStories.add(await storyComposerUseCase.get(element));
    }
    return composedStories;
  }
  
}