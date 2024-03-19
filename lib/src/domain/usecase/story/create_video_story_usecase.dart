import 'dart:async';
import 'dart:io';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/enum/amity_story_data_type.dart';
import 'package:amity_sdk/src/core/enum/amity_story_target_type.dart';
import 'package:amity_sdk/src/core/model/api_request/create_stroy_request.dart';
import 'package:amity_sdk/src/domain/composer_usecase/story_composer_usercase.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/domain/model/amity_story.dart';
import 'package:amity_sdk/src/domain/model/amity_story_item.dart';
import 'package:amity_sdk/src/domain/usecase/story/create_story_usecase.dart';
import 'package:uuid/uuid.dart';

class CreateVideoStoryUseCase extends CreateStoryUseCase {
  CreateVideoStoryUseCase()
      : super(
            storyRepository: serviceLocator.get<StoryRepo>(),
            storyComposerUseCase: serviceLocator.get<StoryComposerUseCase>());

  Future<AmityStory> createVideoStory(
    AmityStoryTargetType targetType,
    String targetId,
    File videoFile,
    List<AmityStoryItem>? storyItems,
    Map<String, dynamic>? metadata,
  ) async {
    // final uploadCompleter = Completer();
    // AmityVideo? video;

    // FileVideoUploadUsecase fileUploadUsecase =
    //     serviceLocator.get<FileVideoUploadUsecase>();
    // fileUploadUsecase
    //     .get(UploadFileRequest(
    //         files: [videoFile], feedtype: AmityContentFeedType.STORY.value))
    //     .asStream()
    //     .listen((event) {
    //   event.when(
    //       progress: (uploadInfo, cancelToken) {},
    //       complete: (file) {
    //         video = file as AmityVideo;
    //         uploadCompleter.complete();
    //       },
    //       error: (error) {
    //         uploadCompleter.completeError(error);
    //         return Future.error(error);
    //       },
    //       cancel: () {});
    // });

    // return uploadCompleter.future.then((value) {
      StoryDataRequest storyDataRequest = StoryDataRequest(
        // fileId: video?.fileId,
      );
      final request = CreateStoryRequest(
        targetType: targetType.value,
        data: storyDataRequest,
        dataType: AmityStoryDataType.VIDEO.value,
        targetId: targetId,
        items: storyItems,
        uri: videoFile,
        metadata: metadata,
        referenceId: Uuid().v4(),
      );
      return get(request);
    // }).onError((error, stackTrace) {
    //   return Future.error(error!);
    // });
  }
}
