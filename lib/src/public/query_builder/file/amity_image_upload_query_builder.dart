import 'dart:async';
import 'dart:io' if (dart.library.html) 'dart:html';

import 'package:amity_sdk/src/core/model/api_request/upload_file_request.dart';
import 'package:amity_sdk/src/domain/model/amity_file/amity_file_info.dart';
import 'package:amity_sdk/src/domain/model/amity_file/amity_upload_result.dart';
import 'package:amity_sdk/src/domain/usecase/file/file_image_upload_usecase.dart';

/// [AmityImageUploadQueryBuilder]

class AmityImageUploadQueryBuilder {
  final FileImageUploadUsecase _usecase;
  final File _file;
  String? _uploadId;
  bool _isFullImage = false;

  /// init [AmityImageUploadQueryBuilder]
  AmityImageUploadQueryBuilder(this._usecase, this._file);

  /// set the upload id for image
  AmityImageUploadQueryBuilder uploadId(String id) {
    _uploadId = id;
    return this;
  }

  /// set if this is full image
  AmityImageUploadQueryBuilder isFullImage(bool isFullImage) {
    _isFullImage = isFullImage;
    return this;
  }

  // Future<AmityUploadResult<AmityImage>> upload() {
  //   UploadFileRequest request = UploadFileRequest();
  //   request.files.add(_file);
  //   request.fullImage = _isFullImage;
  //   if (_uploadId != null) request.uploadId = _uploadId;
  //   return _usecase.get(request);
  // }

  /// excute upload function
  StreamController<AmityUploadResult<AmityImage>> upload() {
    UploadFileRequest request = UploadFileRequest();
    request.files.add(_file);

    if (_uploadId != null) request.uploadId = _uploadId;

    return _usecase.listen(request);
  }
}
