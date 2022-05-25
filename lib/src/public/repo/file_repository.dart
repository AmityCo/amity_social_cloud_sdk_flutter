import 'dart:io';

import 'package:amity_sdk/src/core/service_locator/service_locator.dart';
import 'package:amity_sdk/src/public/query_builder/file/amity_audio_upload_query_builder.dart';
import 'package:amity_sdk/src/public/query_builder/file/amity_file_upload_query_builder.dart';
import 'package:amity_sdk/src/public/query_builder/file/amity_image_upload_query_builder.dart';
import 'package:amity_sdk/src/public/query_builder/file/amity_video_upload_query_builder.dart';

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
