import 'package:amity_sdk/domain/model/amity_file/amity_file.dart';
import 'package:amity_sdk/domain/model/amity_post.dart';

extension AmityPostImageDataExtension on ImageData {
  AmityImage getVideo(AmityImageSize quality) {
    String fileId = rawData![quality.value];
    throw UnknownTarget();
  }
}
