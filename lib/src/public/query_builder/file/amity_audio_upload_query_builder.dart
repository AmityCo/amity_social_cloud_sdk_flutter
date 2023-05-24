import 'dart:io' if (dart.library.html) 'dart:html';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/model/amity_file/amity_file_info.dart';
import 'package:amity_sdk/src/domain/model/amity_file/amity_upload_result.dart';
import 'package:amity_sdk/src/domain/usecase/file/file_audio_upload_usecase.dart';

class AmityAudioUploadQueryBuilder {
  final FileAudioUploadUsecase _usecase;
  final File _file;
  String? _uploadId;

  AmityAudioUploadQueryBuilder(this._usecase, this._file);

  void uploadId(String id) {
    _uploadId = id;
  }

  Future<AmityUploadResult<AmityAudio>> upload() {
    if (_file.lengthSync() > MAX_FILE_SIZE) throw AmityException(message: 'FILE_SIZE_EXCEEDED', code: 800140);

    UploadFileRequest request = UploadFileRequest();
    request.files.add(_file);

    if (_uploadId != null) request.uploadId = _uploadId;

    return _usecase.get(request);
  }
}
