import 'dart:async';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class FileUploadCancelUsecase extends UseCase<void, String> {
  final FileRepo _fileRepo;
  FileUploadCancelUsecase(this._fileRepo);

  @override
  Future<void> get(String params) {
    _fileRepo.cancelUpload(params);
    return Future.value();
  }
}
