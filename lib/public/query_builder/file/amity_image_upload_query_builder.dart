import 'dart:io';

import 'package:amity_sdk/core/model/api_request/upload_file_request.dart';
import 'package:amity_sdk/domain/model/amity_file/amity_file_info.dart';
import 'package:amity_sdk/domain/model/amity_file/amity_upload_result.dart';
import 'package:amity_sdk/domain/usecase/file/file_image_upload_usecase.dart';

class AmityImageUploadQueryBuilder {
  final FileImageUploadUsecase _usecase;
  final File _file;
  String? _uploadId;
  bool _isFullImage = false;

  AmityImageUploadQueryBuilder(this._usecase, this._file);

  void uploadId(String id) {
    _uploadId = id;
  }

  void isFullImage(bool isFullImage) {
    _isFullImage = isFullImage;
  }

  Future<AmityUploadResult<AmityImage>> upload() {
    UploadFileRequest request = UploadFileRequest();
    request.files.add(_file);
    request.fullImage = _isFullImage;
    if (_uploadId != null) request.uploadId = _uploadId;
    return _usecase.get(request);
  }
}
