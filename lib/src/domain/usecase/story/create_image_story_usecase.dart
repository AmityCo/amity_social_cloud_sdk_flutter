import 'dart:async';
import 'dart:io';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/enum/amity_story_data_type.dart';
import 'package:amity_sdk/src/core/enum/amity_story_image_display_mode.dart';
import 'package:amity_sdk/src/core/enum/amity_story_target_type.dart';
import 'package:amity_sdk/src/core/model/api_request/create_stroy_request.dart';
import 'package:amity_sdk/src/domain/composer_usecase/story_composer_usercase.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/domain/model/amity_story.dart';
import 'package:amity_sdk/src/domain/model/amity_story_item.dart';
import 'package:amity_sdk/src/domain/usecase/story/create_story_usecase.dart';
import 'package:uuid/uuid.dart';

class CreateImageStoryUseCase extends CreateStoryUseCase {
  CreateImageStoryUseCase()
      : super(storyRepository: serviceLocator.get<StoryRepo>() , storyComposerUseCase: serviceLocator.get<StoryComposerUseCase>());
  
  
  Future<AmityStory> createImageStory(
    AmityStoryTargetType targetType,
    String targetId,
    File imageFile,
    List<AmityStoryItem>? storyItems,
    Map<String, dynamic>? metadata,
    AmityStoryImageDisplayMode imageDisplayMode,
  ) async {

    // final uploadCompleter = Completer();
    // AmityImage? image;
    
    // FileUploadUsecase fileUploadUsecase =
    //     serviceLocator.get<FileUploadUsecase>();
    // fileUploadUsecase
    //     .get(UploadFileRequest(files: [imageFile], fullImage: true))
    //     .asStream()
    //     .listen((event) {
    //   event.when(
    //       progress: (uploadInfo, cancelToken) {},
    //       complete: (file) {
    //          var amityFile = file as AmityFile;
    //         image = AmityImage( amityFile.getFileProperties!);
    //         uploadCompleter.complete();
    //       },
    //       error: (error) {
    //         uploadCompleter.completeError(error);
    //         return Future.error(error);
    //       },
    //       cancel: () {});
    // });

    // await uploadCompleter.future;

    StoryDataRequest storyDataRequest = StoryDataRequest(
      imageDisplayMode: imageDisplayMode.value,
      // fileId: image?.fileId,
    );
    final request = CreateStoryRequest(
      referenceId: Uuid().v4(),
      targetType: targetType.value,
      dataType: AmityStoryDataType.IMAGE.value,
      data: storyDataRequest,
      targetId: targetId,
      items: storyItems,
      metadata: metadata,
      uri: imageFile
    );
    return get(request);
  }
}
