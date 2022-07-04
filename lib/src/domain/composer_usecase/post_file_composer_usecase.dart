import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class PostFileComposerUsecase extends UseCase<AmityPostData, AmityPostData> {
  final FileRepo fileRepo;
  PostFileComposerUsecase({required this.fileRepo});
  @override
  Future<AmityPostData> get(AmityPostData params) async {
    if (params.fileId != null) {
      final fileProperties = await fileRepo.getFileByIdFromDb(params.fileId!);

      if (params is ImageData) {
        final image = AmityImage(fileProperties);
        params.image = image;
        params.fileInfo = image;
      }

      if (params is VideoData) {
        final thumbnailFile = AmityImage(fileProperties);
        params.thumbnail = thumbnailFile;

        // final videoFile = AmityVideo(_fileProperties);
        // params.fileInfo = videoFile;
      }

      if (params is FileData) {
        final file = AmityFile(fileProperties);
        params.fileInfo = file;
      }
    }
    return params;
  }

  @override
  Stream<AmityPostData> listen(AmityPostData params) {
    // TODO: implement listen
    throw UnimplementedError();
  }
}
