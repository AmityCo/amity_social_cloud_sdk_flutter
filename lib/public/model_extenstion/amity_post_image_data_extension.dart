import 'package:amity_sdk/domain/model/amity_file/amity_file.dart';
import 'package:amity_sdk/domain/model/amity_post.dart';

extension AmityPostImageDataExtension on ImageData {
  String getUrl(AmityImageSize size) {
    return '${image.fileUrl}?size=${size.value}';
  }
}
