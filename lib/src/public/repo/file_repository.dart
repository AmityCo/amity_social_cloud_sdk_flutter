import 'dart:io' if (dart.library.html) 'dart:html';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/public/public.dart';

/// [FileRepository] for all file related operation
class FileRepository {
  /// funtion to upload the file type
  AmityFileUploadQueryBuilder file(File file) {
    return AmityFileUploadQueryBuilder(serviceLocator(), file);
  }

  /// funtion to upload the image type
  AmityImageUploadQueryBuilder image(File file) {
    return AmityImageUploadQueryBuilder(serviceLocator(), file);
  }

  /// funtion to upload the audio type
  AmityAudioUploadQueryBuilder audio(File file) {
    return AmityAudioUploadQueryBuilder(serviceLocator(), file);
  }

  /// funtion to upload the video type
  AmityVideoUploadQueryBuilder video(File file) {
    return AmityVideoUploadQueryBuilder(serviceLocator(), file);
  }
}
