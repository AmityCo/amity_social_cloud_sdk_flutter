import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/domain/model/message/amity_message.dart';

/// [MessageFileComposerUsecase]
class MessageFileComposerUsecase
    extends UseCase<AmityMessageData, AmityMessageData> {
  /// File Repo
  final FileRepo fileRepo;

  /// Init [MessageFileComposerUsecase]
  MessageFileComposerUsecase({required this.fileRepo});
  @override
  Future<AmityMessageData> get(AmityMessageData params) async {
    if (params.fileId != null) {
      final fileProperties = await fileRepo.getFileByIdFromDb(params.fileId!);

      if (params is ImageData) {
        final image = AmityImage(fileProperties);
        // params.image = image;
        // params.fileInfo = image;
      }

      if (params is VideoData) {
        final thumbnailFile = AmityImage(fileProperties);
        // params.thumbnail = thumbnailFile;

        // final videoFile = AmityVideo(_fileProperties);
        // params.fileInfo = videoFile;
      }

      if (params is FileData) {
        final file = AmityFile(fileProperties);
        // params.fileInfo = file;
      }
    }
    return params;
  }

  @override
  Stream<AmityMessageData> listen(AmityMessageData params) {
    // TODO: implement listen
    throw UnimplementedError();
  }
}
