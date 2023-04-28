import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// [CommentFileComposerUsecase]
class CommentFileComposerUsecase extends UseCase<CommentAttachment, CommentAttachment> {
  /// File Repo
  final FileRepo fileRepo;

  /// Init [CommentFileComposerUsecase]
  CommentFileComposerUsecase({required this.fileRepo});
  @override
  Future<CommentAttachment> get(CommentAttachment params) async {
    final fileProperties = await fileRepo.getFileByIdFromDb(params.getFileId());

    if (params is CommentImageAttachment) {
      final image = AmityImage(fileProperties);
      params.image = image;
    }

    return params;
  }
}
