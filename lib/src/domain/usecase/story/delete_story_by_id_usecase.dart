import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/model/api_request/story_delete_by_id_request.dart';
import 'package:amity_sdk/src/domain/composer_usecase/story_composer_usercase.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class DeleteStroyByIdUsecas extends UseCase<bool , StoryDeleteByIdRequest>{

  final StoryRepo storyRepo;
  final StoryComposerUseCase storyComposerUseCase;

  DeleteStroyByIdUsecas({required this.storyRepo, required this.storyComposerUseCase});

  @override
  Future<bool> get(StoryDeleteByIdRequest params) async  {
    return await storyRepo.deleteStoryById(params);
    
  }
  
}