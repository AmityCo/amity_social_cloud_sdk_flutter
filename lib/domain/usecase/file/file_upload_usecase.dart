import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/core/model/api_request/upload_file_request.dart';
import 'package:amity_sdk/domain/domain.dart';

class FileUploadUsecase
    extends UseCase<AmityUploadResult<AmityFile>, UploadFileRequest> {
  final FileRepo _fileRepo;
  FileUploadUsecase(this._fileRepo);
  @override
  Future<AmityUploadResult<AmityFile>> get(UploadFileRequest params) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Stream<AmityUploadResult<AmityFile>> listen(UploadFileRequest params) {
    // TODO: implement listen
    throw UnimplementedError();
  }
}
