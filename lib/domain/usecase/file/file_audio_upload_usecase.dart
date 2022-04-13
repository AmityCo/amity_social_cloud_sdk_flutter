// ignore_for_file: unused_field

import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/domain/domain.dart';

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
