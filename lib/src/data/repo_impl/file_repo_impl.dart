import 'dart:async';

import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:dio/dio.dart';

/// File Repo Layer Impl
class FileRepoImpl extends FileRepo {
  /// File Db Adapter
  final FileDbAdapter fileDbAdapter;

  /// file Api Interface
  final FileApiInterface fileApiInterface;

  /// init [FileRepoImpl]
  FileRepoImpl({required this.fileDbAdapter, required this.fileApiInterface});

  @override
  Future<AmityFileProperties> getFileByIdFromDb(String fileId) {
    return Future.value(fileDbAdapter.getFileEntity(fileId).convertToAmityFileProperties());
  }

  @override
  Future<AmityUploadResult<AmityFile>> uploadFile(
    UploadFileRequest request,
  ) async {
    final data = await fileApiInterface.uploadFile(request);

    final fileProperties = await _saveDataToDb(data);

    return AmityUploadComplete(AmityFile(fileProperties.first));
  }

  Future<List<AmityFileProperties>> _saveDataToDb(List<FileResponse> data) async {
    //Convert to File Hive Entity
    //we have save the file first, since every object depends on file
    List<FileHiveEntity> fileHiveEntities = data.map((e) => e.convertToFileHiveEntity()).toList();

    //Save the File Entity
    for (var e in fileHiveEntities) {
      await fileDbAdapter.saveFileEntity(e);
    }

    return fileHiveEntities.map((e) => e.convertToAmityFileProperties()).toList();
  }

  @override
  Future<AmityUploadResult<AmityAudio>> uploadAudio(
    UploadFileRequest request,
  ) async {
    final data = await fileApiInterface.uploadFile(request);

    final fileProperties = await _saveDataToDb(data);

    return AmityUploadComplete(AmityAudio(fileProperties.first));
  }

  @override
  Future<AmityUploadResult<AmityImage>> uploadImage(
    UploadFileRequest request,
  ) async {
    final data = await fileApiInterface.uploadImage(request);

    final fileProperties = await _saveDataToDb(data);

    return AmityUploadComplete(AmityImage(fileProperties.first));
  }

  @override
  Future<AmityUploadResult<AmityVideo>> uploadVidoe(
    UploadFileRequest request,
  ) async {
    final data = await fileApiInterface.uploadVideo(request);

    final fileProperties = await _saveDataToDb(data);

    return AmityUploadComplete(AmityVideo(fileProperties.first));
  }

  @override
  StreamController<AmityUploadResult<AmityFile>> uploadFileStream(UploadFileRequest request) {
    final controller = StreamController<AmityUploadResult<AmityFile>>();
    final cancelToken = CancelToken();

    try {
      fileApiInterface.uploadFile(
        request,
        onUploadProgress: (int progress, int total) {
          final amityUploadInfo =
              AmityUploadInfo({'progress': ((progress / total) * 100).toInt(), 'contentLength': total});
          controller.add(AmityUploadResult.progress(amityUploadInfo, cancelToken));
        },
        cancelToken: cancelToken,
      ).then((value) async {
        if (cancelToken.isCancelled) {
          //Request Cancelled
          controller.add(AmityUploadResult.cancel());
          return;
        }
        final fileProperties = await _saveDataToDb(value);
        controller.add(AmityUploadResult<AmityFile>.complete(AmityFile(fileProperties.first)));
      }).onError<AmityException>((error, stackTrace) {
        if (error.code == 499) {
          controller.add(AmityUploadResult.cancel());
        } else {
          controller.add(AmityUploadResult.error(error));
        }
      });
    } on DioError catch (error) {
      controller.add(AmityUploadResult.error(error.toAmityExcetion()));
    }

    return controller;
  }

  @override
  StreamController<AmityUploadResult<AmityImage>> uploadImageStream(UploadFileRequest request) {
    final controller = StreamController<AmityUploadResult<AmityImage>>();
    final cancelToken = CancelToken();

    try {
      fileApiInterface.uploadImage(
        request,
        onUploadProgress: (int progress, int total) {
          final amityUploadInfo =
              AmityUploadInfo({'progress': ((progress / total) * 100).toInt(), 'contentLength': total});
          controller.add(AmityUploadResult.progress(amityUploadInfo, cancelToken));
        },
        cancelToken: cancelToken,
      ).then((value) async {
        if (cancelToken.isCancelled) {
          //Request Cancelled
          controller.add(AmityUploadResult.cancel());
          return;
        }
        final fileProperties = await _saveDataToDb(value);
        controller.add(AmityUploadResult<AmityImage>.complete(AmityImage(fileProperties.first)));
      }).onError<AmityException>((error, stackTrace) {
        if (error.code == 499) {
          controller.add(AmityUploadResult.cancel());
        } else {
          controller.add(AmityUploadResult.error(error));
        }
      });
    } catch (error) {
      controller.add(AmityUploadResult.error(error as AmityException));
    }

    return controller;
  }

  @override
  void cancelUpload(String uploadId) {
    fileApiInterface.cancelUpload(uploadId);
  }
}
