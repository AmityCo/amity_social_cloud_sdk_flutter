import 'package:amity_sdk/core/model/api_request/upload_file_request.dart';
import 'package:amity_sdk/domain/model/amity_file/amity_file_info.dart';
import 'package:amity_sdk/domain/model/amity_file/amity_upload_result.dart';

abstract class FileRepo {
  Future<String> getFileByIdFromDb(String fileId);

  Future<AmityUploadResult<AmityFile>> uploadFile(UploadFileRequest request);
  Future<AmityUploadResult<AmityImage>> uploadImage(UploadFileRequest request);
  Future<AmityUploadResult<AmityAudio>> uploadAudio(UploadFileRequest request);
  Future<AmityUploadResult<AmityVideo>> uploadVidoe(UploadFileRequest request);
}
