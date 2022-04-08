import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/domain/domain.dart';

class PostFileComposerUsecase extends UseCase<AmityPostData, AmityPostData> {
  final FileRepo fileRepo;
  PostFileComposerUsecase({required this.fileRepo});
  @override
  Future<AmityPostData> get(AmityPostData params) async {
    if (params.fileId != null) {
      final _fileProperties = await fileRepo.getFileByIdFromDb(params.fileId!);

      if (params is ImageData) {
        final image = AmityImage(_fileProperties);
        params.image = image;
        params.fileInfo = image;
      }

      if (params is VideoData) {
        final thumbnailFile = AmityImage(_fileProperties);
        params.thumbnail = thumbnailFile;

        // final videoFile = AmityVideo(_fileProperties);
        // params.fileInfo = videoFile;
      }

      if (params is FileData) {
        final file = AmityFile(_fileProperties);
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
