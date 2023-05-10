import 'dart:io' if (dart.library.html) 'dart:html';

import 'package:amity_sdk/src/core/model/api_request/upload_file_request.dart';
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

  /* begin_public_function
  id: file.upload.video
  */
  /// Excute Upload
  Future<AmityUploadResult<AmityVideo>> upload() {
    UploadFileRequest request = UploadFileRequest();
    request.files.add(_file);

    if (_uploadId != null) request.uploadId = _uploadId;

    return _usecase.get(request);
  }
  /* end_public_function */
}
