import 'package:amity_sdk/core/model/api_request/upload_file_request.dart';
import 'package:amity_sdk/data/response/response.dart';

abstract class FileApiInterface {
  Future<List<FileResponse>> uploadFile(UploadFileRequest request);
  Future<CreatePostResponse> getFile(String fileId);
  Future<bool> deleteFile(String fileId);
}
