import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// [FileAudioUploadUsecase]
class FileVideoUploadUsecase
    extends UseCase<AmityUploadResult<AmityVideo>, UploadFileRequest> {
  final FileRepo _fileRepo;

  /// init [FileAudioUploadUsecase]
  FileVideoUploadUsecase(this._fileRepo);
  @override
  Future<AmityUploadResult<AmityVideo>> get(UploadFileRequest params) {
    return _fileRepo.uploadVidoe(params);
  }
}
