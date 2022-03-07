import 'dart:io';

import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/data/data.dart';
import 'package:amity_sdk/data/data_source/remote/api_interface/file_api_interface.dart';
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
  Future<CreatePostResponse> uploadFile(File file) async {
    try {
      final data = await httpApiClient().post(FILE_V3 + '/');
      return CreatePostResponse.fromJson(data.data);
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }
}
