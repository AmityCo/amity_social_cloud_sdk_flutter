import 'package:amity_sdk/src/core/model/api_request/upload_file_request.dart';
import 'package:amity_sdk/src/data/response/response.dart';
import 'package:dio/dio.dart';

abstract class FileApiInterface {
  Future<List<FileResponse>> uploadFile(UploadFileRequest request,
      {ProgressCallback? onUploadProgress, CancelToken? cancelToken});
  Future<List<FileResponse>> uploadVideo(UploadFileRequest request,
      {ProgressCallback? onUploadProgress, CancelToken? cancelToken});
  Future<CreatePostResponse> getFile(String fileId);
  Future<bool> deleteFile(String fileId);
  void cancelUpload(String uploadId);
}
