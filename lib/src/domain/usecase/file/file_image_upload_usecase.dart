import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// [FileImageUploadUsecase]
class FileImageUploadUsecase
    extends UseCase<AmityUploadResult<AmityImage>, UploadFileRequest> {
  final FileRepo _fileRepo;

  /// init [FileImageUploadUsecase]
  FileImageUploadUsecase(this._fileRepo);
  @override
  Future<AmityUploadResult<AmityImage>> get(UploadFileRequest params) {
    return _fileRepo.uploadImage(params);
  }
}
