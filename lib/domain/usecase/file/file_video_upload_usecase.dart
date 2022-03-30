import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/domain/domain.dart';

class FileVideoUploadUsecase
    extends UseCase<AmityUploadResult<AmityVideo>, UploadFileRequest> {
  final FileRepo _fileRepo;
  FileVideoUploadUsecase(this._fileRepo);
  @override
  Future<AmityUploadResult<AmityVideo>> get(UploadFileRequest params) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Stream<AmityUploadResult<AmityVideo>> listen(UploadFileRequest params) {
    // TODO: implement listen
    throw UnimplementedError();
  }
}
