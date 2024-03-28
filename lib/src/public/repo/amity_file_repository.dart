import 'dart:async';
import 'dart:io' if (dart.library.html) 'dart:html';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// [AmityFileRepository] for all file related operation
class AmityFileRepository {
  /*  begin_public_function
  id: file.upload.file
  api_style: async
  */
  /// funtion to upload the file type
  StreamController<AmityUploadResult<AmityFile>> uploadFile(File file, {String? uploadId }) {
    return serviceLocator<FileUploadUsecase>().listen(UploadFileRequest(files: [file], uploadId: uploadId));
  }
  /* end_public_function */

  /*  begin_public_function
  id: file.upload.image
  api_style: async
  */
  /// funtion to upload the image type
  StreamController<AmityUploadResult<AmityImage>> uploadImage(File file, {String? uploadId, bool isFullImage = false}) {
    return serviceLocator<FileImageUploadUsecase>()
        .listen(UploadFileRequest(files: [file], uploadId: uploadId, fullImage: isFullImage));
  }
  /* end_public_function */

  /*  begin_public_function
  id: file.upload.audio
  api_style: async
  */
  /// funtion to upload the audio type
  Future<AmityUploadResult<AmityAudio>> uploadAudio(File file, {String? uploadId}) {
    return serviceLocator<FileAudioUploadUsecase>().get(UploadFileRequest(files: [file], uploadId: uploadId));
  }
  /* end_public_function */

  /*  begin_public_function
  id: file.upload.video
  api_style: async
  */
  /// funtion to upload the video type
  StreamController<AmityUploadResult<AmityVideo>> uploadVideo(File file, {String? uploadId , AmityContentFeedType? feedtype}) {
    return serviceLocator<FileVideoUploadUsecase>().listen(UploadFileRequest(files: [file], uploadId: uploadId , feedtype: feedtype?.value));
  }
  /* end_public_function */

  /// funtion to upload the video type
  void cancelUpload(String uploadId) {
    serviceLocator<FileUploadCancelUsecase>().get(uploadId);
  }
}
