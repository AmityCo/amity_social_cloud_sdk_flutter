import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/domain/model/amity_file/amity_file_info.dart';
import 'package:amity_sdk/domain/model/amity_file/amity_upload_info.dart';

abstract class AmityUploadResult<T extends AmityFileInfo> {}

class AmityUploadInProgress extends AmityUploadResult {
  final AmityUploadInfo _uploadInfo;
  AmityUploadInProgress(this._uploadInfo);

  AmityUploadInfo get getUploadInfo => _uploadInfo;

  @override
  String toString() => 'AmityUploadInProgress(_uploadInfo: $_uploadInfo)';
}

class AmityUploadComplete<T extends AmityFileInfo>
    extends AmityUploadResult<T> {
  final T _file;

  AmityUploadComplete(this._file);
  AmityFileInfo get getFile => _file;

  @override
  String toString() => 'AmityUploadComplete(_fileInfo: $_file)';
}

class AmityUploadError extends AmityUploadResult {
  final AmityException _error;
  AmityUploadError(this._error);

  AmityException get getErrror => _error;

  @override
  String toString() => 'AmityUploadError(_error: $_error)';
}

class AmityUploadCancel extends AmityUploadResult {}
