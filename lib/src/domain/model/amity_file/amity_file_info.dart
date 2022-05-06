// ignore_for_file: constant_identifier_names

import 'package:amity_sdk/src/domain/model/amity_file/amity_file_properties.dart';

abstract class AmityFileInfo {
  final AmityFileProperties _fileProperties;
  AmityFileInfo(this._fileProperties);

  AmityFileProperties get getFileProperties {
    return _fileProperties;
  }

  String get fileId => _fileProperties.fileId!;
  // set fileId(String fileId) => _fileProperties.fileId = fileId;

  String get fileUrl => _fileProperties.fileUrl!;
  // set fileUrl(String fileId) => _fileProperties.fileId = fileUrl;

  String get fileExtension => _fileProperties.ext!;

  String get fileName => _fileProperties.name!;

  String getMimeType() {
    return _fileProperties.mimeType!;
  }

  String get fileSize => _fileProperties.size!;

  String getFilePath() {
    throw UnimplementedError();
  }

  @override
  String toString() => 'AmityFileInfo(_fileProperties: $_fileProperties)';
}

class AmityFile extends AmityFileInfo {
  AmityFile(AmityFileProperties _fileProperties) : super(_fileProperties);
}

class AmityImage extends AmityFileInfo {
  AmityImage(AmityFileProperties _fileProperties) : super(_fileProperties);

  String getUrl(AmityImageSize size) {
    return '$fileUrl?size=${size.value}';
  }

  int getWidth() {
    return getFileProperties.width!;
  }

  int getHeight() {
    return getFileProperties.height!;
  }

  bool isFullImage() {
    return getFileProperties.isFull!;
  }
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
  AmityVideo(AmityFileProperties _fileProperties) : super(_fileProperties);
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
