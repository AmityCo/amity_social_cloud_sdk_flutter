import 'package:amity_sdk/amity_sdk.dart';

sealed class AmityStoryData {}

class ImageStoryData extends AmityStoryData {
  final String storyId;
  final Map<String, dynamic> rawData;
  final AmityStoryImageDisplayMode imageDisplayMode;
  final AmityImage image;
  ImageStoryData({
    required this.storyId,
    required this.rawData,
    required this.imageDisplayMode,
    required this.image,
  });
}

class VideoStoryData extends AmityStoryData {
  final String storyId;
  final Map<String, dynamic> rawData;
  final AmityImage thumbnail;
  final AmityVideo video;
  VideoStoryData({
    required this.storyId,
    required this.rawData,
    required this.thumbnail,
    required this.video,
  });
}

class UnknownStoryData extends AmityStoryData {
  UnknownStoryData();
}
