import 'dart:core';
import 'dart:io';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/model/api_request/story_delete_by_id_request.dart';
import 'package:amity_sdk/src/domain/model/amity_story_item.dart';
import 'package:amity_sdk/src/domain/usecase/story/create_image_story_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/story/create_video_story_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/story/delete_story_by_id_usecase.dart';
import 'package:amity_sdk/src/public/query_builder/story/story.dart';

class AmityStoryRepository {
  Future createImageStory({
    required AmityStoryTargetType targetType,
    required String targetId,
    required File imageFile,
    List<AmityStoryItem>? storyItems,
    Map<String, dynamic>? metadata,
    required AmityStoryImageDisplayMode imageDisplayMode,
  }) async {
    return CreateImageStoryUseCase().createImageStory(targetType, targetId, imageFile,
        storyItems, metadata, imageDisplayMode);
  }

  Future createVideoStory({
    required AmityStoryTargetType targetType,
    required String targetId,
    required File videoFile,
    List<AmityStoryItem>? storyItems,
    Map<String, dynamic>? metadata,
  }) async {
   return CreateVideoStoryUseCase().createVideoStory(
        targetType, targetId, videoFile, storyItems, metadata);
  }

  AmityStoryGetQueryBuilder getActiveStories(
      {required String targetId,
      required AmityStoryTargetType targetType,
      AmityStorySortingOrder orderBy = AmityStorySortingOrder.LAST_CREATED}) {
    return AmityStoryGetQueryBuilder()
        .targetId(targetId)
        .targetType(targetType)
        .orderBy(orderBy);
  }

  AmityStoryGetQueryBuilder getStoriesByTargets(
      {required Map<AmityStoryTargetType, String> targets,
      AmityStorySortingOrder orderBy = AmityStorySortingOrder.LAST_CREATED}) {
    return AmityStoryGetQueryBuilder()
        .targets(targets)
        .orderBy(orderBy);
  }

  Future hardDeleteStory({required String storyId}) async {
   return  serviceLocator<DeleteStroyByIdUsecas>().get(StoryDeleteByIdRequest( storyId: storyId, permanentDelete: true));
  }


  Future softDeleteStory({required String storyId}) async {
    return serviceLocator<DeleteStroyByIdUsecas>().get(StoryDeleteByIdRequest( storyId: storyId, permanentDelete: false));
  }



}
