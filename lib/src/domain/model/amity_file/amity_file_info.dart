// ignore_for_file: constant_identifier_names

import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/core/enum/amity_broadcast_resolution.dart';
import 'package:amity_sdk/src/domain/model/amity_file/amity_file_properties.dart';

abstract class AmityFileInfo {
  final AmityFileProperties? _fileProperties;
  AmityFileInfo(this._fileProperties);

  AmityFileProperties? get getFileProperties {
    return _fileProperties;
  }

  String? get fileId => _fileProperties?.fileId;
  // set fileId(String fileId) => _fileProperties.fileId = fileId;

  String? get fileUrl => _fileProperties?.fileUrl;
  // set fileUrl(String fileId) => _fileProperties.fileId = fileUrl;

  String? get fileExtension => _fileProperties?.ext;

  String? get fileName => _fileProperties?.name!;

  String? getMimeType() {
    return _fileProperties?.mimeType;
  }

  String? get fileSize => _fileProperties?.size;

  bool? get _hasLocalPreview => _fileProperties?.filePath != null;

  /// Get Local preview file path
  String? get _getFilePath => _fileProperties?.filePath;

  @override
  String toString() => 'AmityFileInfo(_fileProperties: $_fileProperties)';
}

/// [AmityFile]
class AmityFile extends AmityFileInfo {
  /// init [AmityFile]
  AmityFile(AmityFileProperties fileProperties) : super(fileProperties);

  /// Get url
  String? get getUrl => fileUrl;

  /// Check if Image have local preview
  bool? get hasLocalPreview => _hasLocalPreview;

  /// get local preview file path
  /// Plese check if before if Amity Image have [hasLocalPreview]
  String? get getFilePath => _getFilePath;
}

/// Amity Image Object
class AmityImage extends AmityFileInfo {
  /// init [AmityImage]
  AmityImage(AmityFileProperties fileProperties) : super(fileProperties);

  /// Get url
  String getUrl(AmityImageSize size) {
    return '$fileUrl?size=${size.value}';
  }

  /// Get Width
  int? getWidth() {
    return getFileProperties?.width!;
  }

  /// Get Height
  int? getHeight() {
    return getFileProperties?.height!;
  }

  /// is Full Image
  bool? isFullImage() {
    return getFileProperties?.isFull!;
  }

  /// Check if Image have local preview
  bool? get hasLocalPreview => _hasLocalPreview;

  /// get local preview file path
  /// Plese check if before if Amity Image have [hasLocalPreview]
  String? get getFilePath => _getFilePath;
}

enum AmityImageSize {
  SMALL,
  MEDIUM,
  LARGE,
  FULL,
}

extension AmityImageSizeExtension on AmityImageSize {
  String get value {
    return AmityImageSize.values[index].name.toLowerCase();
  }

  //TODO - this method need to acceesable with AmityDataType
  static AmityImageSize enumOf(String value) {
    return AmityImageSize.values.firstWhere(
        (element) => element.name.toLowerCase() == value.toLowerCase(),
        orElse: () => AmityImageSize.MEDIUM);
  }
}

///Amity Video
class AmityVideo extends AmityFileInfo {
  bool? get hasLocalPreview => _hasLocalPreview;
  String? get getFilePath => _getFilePath;
  AmityFileProperties fileProperties;

  AmityVideo(this.fileProperties) : super(fileProperties);

  List<AmityVideoResolution> getResolutions() {
    List<AmityVideoResolution> resolutions = [];
    fileProperties.rawFile?['videoUrl']?.keys.toList().forEach((e) {
      resolutions.add(AmityVideoResolutionExtension.enumOf(e));
    });
    return resolutions;
  }

  String? getVideoUrl(AmityVideoResolution resolution) {
    return fileProperties.rawFile?['videoUrl'][resolution.apiKey];
  }
}

enum AmityVideoQuality { ORIGINAL, HIGH, MEDIUM, LOW }

extension AmityVideoQualityExtension on AmityVideoQuality {
  String get value {
    return AmityVideoQuality.values[index].name.toLowerCase();
  }

  //TODO - this method need to acceesable with AmityDataType
  static AmityVideoQuality enumOf(String value) {
    return AmityVideoQuality.values.firstWhere(
        (element) => element.name.toLowerCase() == value.toLowerCase(),
        orElse: () => AmityVideoQuality.ORIGINAL);
  }
}

///

class AmityAudio extends AmityFileInfo {
  AmityAudio(AmityFileProperties fileProperties) : super(fileProperties);
}
