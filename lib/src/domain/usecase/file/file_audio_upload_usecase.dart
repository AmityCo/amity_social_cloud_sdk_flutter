import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class FileAudioUploadUsecase
    extends UseCase<AmityUploadResult<AmityAudio>, UploadFileRequest> {
  final FileRepo _fileRepo;
  FileAudioUploadUsecase(this._fileRepo);
  @override
  Future<AmityUploadResult<AmityAudio>> get(UploadFileRequest params) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Stream<AmityUploadResult<AmityAudio>> listen(UploadFileRequest params) {
    // TODO: implement listen
    throw UnimplementedError();
  }
}
