import 'dart:io';

import 'package:amity_sdk/amity_sdk.dart';

class AmityStoryCreateVideoStory {
  /* begin_sample_code
    gist_id: 1d5d8610a611b4c77be844cab3c10a14
    filename: AmityStoryCreateVideoStory.dart
    asc_page: https://docs.amity.co/social/flutter
    description: Flutter create video story example
    */

  void createVideoStory(
      AmityStoryRepository storyRepository,
      AmityStoryTargetType targetType,
      String targetId,
      File videoFile,
      String hyperlink,
      String linkAlias) {
    storyRepository.createVideoStory(
        targetType: targetType,
        targetId: targetId,
        videoFile: videoFile,
        storyItems: [
          HyperLink(
            url: hyperlink,
            customText: linkAlias,
          ),
        ]).onError((error, stackTrace) {
      // Handle Error
    });
  }
  /* end_sample_code */
}
