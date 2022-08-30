// ignore_for_file: unused_field

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// [FileAudioUploadUsecase]
class FileAudioUploadUsecase
    extends UseCase<AmityUploadResult<AmityAudio>, UploadFileRequest> {
  final FileRepo _fileRepo;

  /// init [FileAudioUploadUsecase]
  FileAudioUploadUsecase(this._fileRepo);
  @override
  Future<AmityUploadResult<AmityAudio>> get(UploadFileRequest params) {
    throw UnimplementedError();
  }

  @override
  Stream<AmityUploadResult<AmityAudio>> listen(UploadFileRequest params) {
    throw UnimplementedError();
  }
}
