import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/domain/domain.dart';

class FileImageUploadUsecase
    extends UseCase<AmityUploadResult<AmityImage>, UploadFileRequest> {
  final FileRepo _fileRepo;
  FileImageUploadUsecase(this._fileRepo);
  @override
  Future<AmityUploadResult<AmityImage>> get(UploadFileRequest params) {
    return _fileRepo.uploadImage(params);
  }

  @override
  Stream<AmityUploadResult<AmityImage>> listen(UploadFileRequest params) {
    // TODO: implement listen
    throw UnimplementedError();
  }
}
