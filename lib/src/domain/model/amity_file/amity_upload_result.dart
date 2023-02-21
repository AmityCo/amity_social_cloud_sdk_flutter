import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'amity_upload_result.freezed.dart';

@freezed
class AmityUploadResult<T> with _$AmityUploadResult {
  const factory AmityUploadResult.progress(
          AmityUploadInfo uploadInfo, CancelToken cancelToken) =
      AmityUploadInProgress;
  const factory AmityUploadResult.complete(T file) = AmityUploadComplete;
  const factory AmityUploadResult.error(AmityException error) =
      AmityUploadError;
  const factory AmityUploadResult.cancel() = AmityUploadCancel;
}

extension AmityUploadInProgressExtension on AmityUploadInProgress {
  AmityUploadInfo get getUploadInfo => uploadInfo;
}

extension AmityUploadCompleteExtension on AmityUploadComplete {
  AmityFileInfo get getFile => file;
}

extension AmityUploadErrorExtension on AmityUploadError {
  AmityException get getError => error;
}

// class AmityUploadInProgress<T extends AmityFileInfo>
//     extends AmityUploadResult<T> {
//   final AmityUploadInfo _uploadInfo;
//   final CancelToken cancelToken;
//   AmityUploadInProgress(this.cancelToken, this._uploadInfo)
//       : super(AmityUploadState.progress);

//   AmityUploadInfo get getUploadInfo => _uploadInfo;

//   void cancel({String? reason}) {
//     cancelToken.cancel(reason);
//   }

//   @override
//   String toString() => 'AmityUploadInProgress(_uploadInfo: $_uploadInfo)';
// }

// class AmityUploadComplete<T extends AmityFileInfo>
//     extends AmityUploadResult<T> {
//   final T _file;

//   AmityUploadComplete(this._file) : super(AmityUploadState.complete);
//   AmityFileInfo get getFile => _file;

//   @override
//   String toString() => 'AmityUploadComplete(_fileInfo: $_file)';
// }

// class AmityUploadError<T extends AmityFileInfo> extends AmityUploadResult<T> {
//   final AmityException _error;
//   AmityUploadError(this._error) : super(AmityUploadState.error);

//   AmityException get getError => _error;

//   @override
//   String toString() => 'AmityUploadError(_error: $_error)';
// }

// class AmityUploadCancel<T extends AmityFileInfo> extends AmityUploadResult<T> {
//   AmityUploadCancel() : super(AmityUploadState.error);
// }

// enum AmityUploadState { progress, complete, error, cancelled }
