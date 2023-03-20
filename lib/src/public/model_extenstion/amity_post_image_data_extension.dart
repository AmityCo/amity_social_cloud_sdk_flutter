import 'package:amity_sdk/src/domain/model/amity_file/amity_file.dart';
import 'package:amity_sdk/src/domain/model/amity_post.dart';

/// Amity Post Image Data
extension AmityPostImageDataExtension on ImageData {
  /// Get Image Url
  String getUrl(AmityImageSize size) {
    return '${image!.fileUrl}?size=${size.value}';
  }
}
