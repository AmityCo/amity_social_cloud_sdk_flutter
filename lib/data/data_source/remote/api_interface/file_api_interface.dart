import 'dart:io';

import 'package:amity_sdk/data/response/response.dart';

abstract class FileApiInterface {
  Future<CreatePostResponse> uploadFile(File file);
  Future<CreatePostResponse> getFile(String fileId);
  Future<bool> deleteFile(String fileId);
}
