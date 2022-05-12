import 'dart:io';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/public/public.dart';

class FileRepository {
  AmityFileUploadQueryBuilder file(File file) {
    return AmityFileUploadQueryBuilder(serviceLocator(), file);
  }

  AmityImageUploadQueryBuilder image(File file) {
    return AmityImageUploadQueryBuilder(serviceLocator(), file);
  }

  AmityAudioUploadQueryBuilder audio(File file) {
    return AmityAudioUploadQueryBuilder(serviceLocator(), file);
  }

  AmityVideoUploadQueryBuilder video(File file) {
    return AmityVideoUploadQueryBuilder(serviceLocator(), file);
  }
}
