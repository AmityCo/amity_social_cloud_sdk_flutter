import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class StoryComposerUseCase extends UseCase<AmityStory, AmityStory> {
  /// User Repo
  final UserRepo userRepo;

  /// User Composer UseCase
  final UserComposerUsecase userComposerUsecase;

  /// File Repo
  final FileRepo fileRepo;

  /// Post File Composer UseCase
  StoryComposerUseCase(
      {required this.userRepo,
      required this.userComposerUsecase,
      required this.fileRepo});

  @override
  Future<AmityStory> get(AmityStory params) async {
    final user = await userRepo.getUserByIdFromDb(params.creatorPublicId!);
    final composedUser = await userComposerUsecase.get(user);
    params.creator = composedUser;
    AmityStoryData storyData = UnknownStoryData();
    switch (params.dataType) {
      case AmityStoryDataType.IMAGE:
        storyData = ImageStoryData(
            storyId: params.storyId!,
            rawData: params.rawData!,
            imageDisplayMode: AmityStoryImageDisplayModeExtension.enumOf(
                params.rawData?["imageDisplayMode"]),
            image: await getImageFile(params));
        break;
      case AmityStoryDataType.VIDEO:
        storyData = VideoStoryData(
            storyId: params.storyId!,
            rawData: params.rawData!,
            video: await getVideoFile(params),
            thumbnail: await getThumbnailFile(params));
        break;
      default:
        storyData = UnknownStoryData();
    }

    params.data = storyData;

    return params;
  }

  Future<AmityVideo> getVideoFile(AmityStory story) async {
    var fileProperties =
        await fileRepo.getFileByIdFromDb(getVideoId( story.rawData));
    return AmityVideo(fileProperties);
  }

  Future<AmityImage> getImageFile(AmityStory story) async {
    var fileProperties =
        await fileRepo.getFileByIdFromDb(getImageId(story.rawData));
    return AmityImage(fileProperties);
  }

  Future<AmityImage> getThumbnailFile(AmityStory story) async {
    var fileProperties =
        await fileRepo.getFileByIdFromDb(getThumbnailId(story.rawData));
    return AmityImage(fileProperties);
  }

  String getVideoId(Map<String, dynamic>? rawData) {
    return rawData?["videoFileId"]?["original"] ?? rawData?["fileId"];
  }

  String getImageId(Map<String, dynamic>? rawData) {
    return rawData?["fileId"] ?? "";
  }

  String getThumbnailId(Map<String, dynamic>? rawData) {
    return rawData?["thumbnailFileId"] ?? "";
  }
}
