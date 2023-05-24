import 'dart:io' if (dart.library.html) 'dart:html';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/model/amity_file/amity_file_info.dart';
import 'package:amity_sdk/src/domain/model/amity_file/amity_upload_result.dart';
import 'package:amity_sdk/src/domain/usecase/file/file_video_upload_usecase.dart';

/// [AmityVideoUploadQueryBuilder]
class AmityVideoUploadQueryBuilder {
  final FileVideoUploadUsecase _usecase;
  final File _file;
  String? _uploadId;

  /// init [AmityVideoUploadQueryBuilder]
  AmityVideoUploadQueryBuilder(this._usecase, this._file);

  /// Upload ID
  AmityVideoUploadQueryBuilder uploadId(String id) {
    _uploadId = id;
    return this;
  }

  /// Excute Upload
  Future<AmityUploadResult<AmityVideo>> upload() {
    if (_file.lengthSync() > MAX_FILE_SIZE) throw AmityException(message: 'FILE_SIZE_EXCEEDED', code: 800140);

    UploadFileRequest request = UploadFileRequest();
    request.files.add(_file);

    if (_uploadId != null) request.uploadId = _uploadId;

    return _usecase.get(request);
  }
}
