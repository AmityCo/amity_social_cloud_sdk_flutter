import 'dart:async';

import 'package:amity_sdk/src/core/model/api_request/upload_file_request.dart';
import 'package:amity_sdk/src/domain/model/amity_file/amity_file_info.dart';
import 'package:amity_sdk/src/domain/model/amity_file/amity_file_properties.dart';
import 'package:amity_sdk/src/domain/model/amity_file/amity_upload_result.dart';

abstract class FileRepo {
  Future<AmityFileProperties> getFileByIdFromDb(String fileId);

  Future<AmityUploadResult<AmityFile>> uploadFile(UploadFileRequest request);
  StreamController<AmityUploadResult<AmityFile>> uploadFileStream(UploadFileRequest request);
  Future<AmityUploadResult<AmityImage>> uploadImage(UploadFileRequest request);
  StreamController<AmityUploadResult<AmityImage>> uploadImageStream(UploadFileRequest request);
  Future<AmityUploadResult<AmityAudio>> uploadAudio(UploadFileRequest request);
  Future<AmityUploadResult<AmityVideo>> uploadVidoe(UploadFileRequest request);
  void cancelUpload(String uploadId);
}
