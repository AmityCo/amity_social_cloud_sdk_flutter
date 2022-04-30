import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class FileUploadUsecase
    extends UseCase<AmityUploadResult<AmityFile>, UploadFileRequest> {
  final FileRepo _fileRepo;
  FileUploadUsecase(this._fileRepo);
  @override
  Future<AmityUploadResult<AmityFile>> get(UploadFileRequest params) {
    return _fileRepo.uploadFile(params);
  }

  @override
  Stream<AmityUploadResult<AmityFile>> listen(UploadFileRequest params) {
    // TODO: implement listen
    throw UnimplementedError();
  }
}
