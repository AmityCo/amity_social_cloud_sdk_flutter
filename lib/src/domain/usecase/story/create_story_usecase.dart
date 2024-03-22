import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/model/api_request/create_stroy_request.dart';
import 'package:amity_sdk/src/domain/composer_usecase/story_composer_usercase.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/domain/model/amity_story.dart';

class CreateStoryUseCase extends UseCase<AmityStory, CreateStoryRequest>{


  final StoryRepo storyRepository;

  final StoryComposerUseCase storyComposerUseCase;

  CreateStoryUseCase({required this.storyRepository , required this.storyComposerUseCase});


  @override
  Future<AmityStory> get(CreateStoryRequest params) async {
    var  story = await storyRepository.createStory(params);
    story = await storyComposerUseCase.get(story);
    return story;
  }

}