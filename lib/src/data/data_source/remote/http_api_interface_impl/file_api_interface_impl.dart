// ignore_for_file: unused_local_variable

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:dio/dio.dart';

/// File API layer implementation
class FileApiInterfaceImpl extends FileApiInterface {
  /// Cancel token pool
  final cancelTokenPool = <String, CancelToken>{};

  /// HttpClient
  final HttpApiClient httpApiClient;

  /// init [FileApiInterfaceImpl]
  FileApiInterfaceImpl({required this.httpApiClient});

  @override
  Future<bool> deleteFile(String fileId) async {
    try {
      final data = await httpApiClient().delete('$FILE_V3/$fileId');
      return true;
    } on DioException catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future<CreatePostResponse> getFile(String fileId) async {
    try {
      final data = await httpApiClient().get('$FILE_V3/$fileId');
      return CreatePostResponse.fromJson(data.data);
    } on DioException catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future<List<FileResponse>> uploadFile(UploadFileRequest request,
      {ProgressCallback? onUploadProgress, CancelToken? cancelToken}) async {
    try {
      if (cancelToken != null && request.uploadId != null) {
        cancelTokenPool[request.uploadId!] = cancelToken;
      }

      /// If we want to support multiple file upload it future
      // var formData = FormData.fromMap({
      //   'files': Stream.fromIterable(request.files)
      //       .asyncMap((event) async => await MultipartFile.fromFile(event.path,
      //           filename: event.path.split('/').last))
      //       .toList(),
      // }..addAll(request.toJson()));
      var formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          request.files[0].path,
          filename: request.files[0].path.split('/').last,
        ),
      }..addAll(request.toJson()));

      final data = await httpApiClient()
          .post('$FILE_V3/', data: formData, onSendProgress: onUploadProgress, cancelToken: cancelToken);
      return fileResponseFromList(data.data);
    } on DioException catch (error) {
      return Future.error(error.toAmityExcetion());
    }
  }

  @override
  Future<List<FileResponse>> uploadImage(UploadFileRequest request,
      {ProgressCallback? onUploadProgress, CancelToken? cancelToken}) async {
    try {
      if (cancelToken != null && request.uploadId != null) {
        cancelTokenPool[request.uploadId!] = cancelToken;
      }

      /// If we want to support multiple file upload it future
      // var formData = FormData.fromMap({
      //   // 'files': Stream.fromIterable(request.files)
      //   //     .asyncMap((event) async => await MultipartFile.fromFile(event.path, filename: event.path.split('/').last))
      //   //     .toList(),
      //   'files': List.generate(
      //       request.files.length,
      //       (index) async => await MultipartFile.fromFile(request.files[index].path,
      //           filename: request.files[index].path.split('/').last))
      // }..addAll(request.toJson()));
      var formData = FormData.fromMap({
        'files': await MultipartFile.fromFile(
          request.files[0].path,
          filename: request.files[0].path.split('/').last,
        ),
      }..addAll(request.toJson()));

      final data = await httpApiClient()
          .post('$IMAGE_FILE_V4/', data: formData, onSendProgress: onUploadProgress, cancelToken: cancelToken);

      return fileResponseFromList(data.data);
    } on DioException catch (error) {
      return Future.error(error.toAmityExcetion());
    }
  }

  @override
  Future<List<FileResponse>> uploadVideo(UploadFileRequest request,
      {ProgressCallback? onUploadProgress, CancelToken? cancelToken}) async {
    try {
      if (cancelToken != null && request.uploadId != null) {
        cancelTokenPool[request.uploadId!] = cancelToken;
      }

      /// If we want to support multiple file upload it future
      // var formData = FormData.fromMap({
      //   'files': Stream.fromIterable(request.files)
      //       .asyncMap((event) async => await MultipartFile.fromFile(event.path,
      //           filename: event.path.split('/').last))
      //       .toList(),
      // }..addAll(request.toJson()));

      // Upload single file
      var formData = FormData.fromMap({
        'files': await MultipartFile.fromFile(
          request.files[0].path,
          filename: request.files[0].path.split('/').last,
        ),
        'feedType': request.feedtype,
      }..addAll(request.toJson()));

      final data = await httpApiClient()
          .post('$VIDEO_FILE_V4/', data: formData, onSendProgress: onUploadProgress, cancelToken: cancelToken);

      return fileResponseFromList(data.data);
    } on DioException catch (error) {
      return Future.error(error.toAmityExcetion());
    }
  }

  @override
  void cancelUpload(String uploadId) {
    if (cancelTokenPool.containsKey(uploadId)) {
      cancelTokenPool[uploadId]!.cancel();
    }
  }
}
