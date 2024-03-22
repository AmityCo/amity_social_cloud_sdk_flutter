import 'dart:io';

import 'package:amity_sdk/amity_sdk.dart';

class AmityStoryCreateImageStory {
  /* begin_sample_code
    gist_id: 173ae4b723bb2e36eb0875c0978aa4fb
    filename: AmityStoryCreateImageStory.dart
    asc_page: https://docs.amity.co/social/flutter
    description: Flutter create image story example
    */

  void createImageStory(
      AmityStoryRepository storyRepository,
      AmityStoryTargetType targetType,
      String targetId,
      File imageFile,
      String hyperlink,
      String linkAlias) async {
    storyRepository.createImageStory(
        targetType: targetType,
        targetId: targetId,
        imageFile: imageFile,
        imageDisplayMode: AmityStoryImageDisplayMode.FIT,
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
