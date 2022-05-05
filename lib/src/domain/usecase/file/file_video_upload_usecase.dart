import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class FileVideoUploadUsecase
    extends UseCase<AmityUploadResult<AmityVideo>, UploadFileRequest> {
  final FileRepo _fileRepo;
  FileVideoUploadUsecase(this._fileRepo);
  @override
  Future<AmityUploadResult<AmityVideo>> get(UploadFileRequest params) {
    return _fileRepo.uploadVidoe(params);
  }

  @override
  Stream<AmityUploadResult<AmityVideo>> listen(UploadFileRequest params) {
    // TODO: implement listen
    throw UnimplementedError();
  }
}
