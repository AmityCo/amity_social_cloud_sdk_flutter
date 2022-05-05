import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:dio/dio.dart';

class FileApiInterfaceImpl extends FileApiInterface {
  final HttpApiClient httpApiClient;

  FileApiInterfaceImpl({required this.httpApiClient});

  @override
  Future<bool> deleteFile(String fileId) async {
    try {
      final data = await httpApiClient().delete(FILE_V3 + '/$fileId');
      return true;
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future<CreatePostResponse> getFile(String fileId) async {
    try {
      final data = await httpApiClient().get(FILE_V3 + '/$fileId');
      return CreatePostResponse.fromJson(data.data);
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future<List<FileResponse>> uploadFile(UploadFileRequest request) async {
    try {
      /// If we want to support multiple file upload it future
      // var formData = FormData.fromMap({
      //   'files': Stream.fromIterable(request.files)
      //       .asyncMap((event) async => await MultipartFile.fromFile(event.path,
      //           filename: event.path.split('/').last))
      //       .toList(),
      // }..addAll(request.toJson()));
      var formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(request.files[0].path,
            filename: request.files[0].path.split('/').last),
      }..addAll(request.toJson()));
      final data = await httpApiClient().post(FILE_V3 + '/', data: formData);
      return fileResponseFromList(data.data);
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future<List<FileResponse>> uploadVideo(UploadFileRequest request) async {
    try {
      /// If we want to support multiple file upload it future
      // var formData = FormData.fromMap({
      //   'files': Stream.fromIterable(request.files)
      //       .asyncMap((event) async => await MultipartFile.fromFile(event.path,
      //           filename: event.path.split('/').last))
      //       .toList(),
      // }..addAll(request.toJson()));

      // Upload single file
      var formData = FormData.fromMap({
        'files': await MultipartFile.fromFile(request.files[0].path,
            filename: request.files[0].path.split('/').last),
      }..addAll(request.toJson()));
      final data =
          await httpApiClient().post(VIDEO_FILE_V3 + '/', data: formData);
      return fileResponseFromList(data.data);
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }
}
