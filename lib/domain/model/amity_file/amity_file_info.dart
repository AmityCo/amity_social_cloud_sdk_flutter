import 'package:amity_sdk/domain/model/amity_file/amity_file_properties.dart';

abstract class AmityFileInfo {
  final AmityFileProperties _fileProperties;
  AmityFileInfo(this._fileProperties);

  AmityFileProperties get getFileProperties {
    return _fileProperties;
  }

  // Map<String, dynamic>? _getAttributes() {
  //   return _fileProperties["attributes"] as Map<String, dynamic>;
  // }

  // Map<String, dynamic> getMetaData() {
  //   return _getAttributes()?['metadata'] as Map<String, dynamic>;
  // }

  String getFileId() {
    return _fileProperties.fileId!;
  }

  String getFileUrl() {
    return _fileProperties.fileUrl!;
  }

  String getFileExtension() {
    return _fileProperties.ext!;
  }

  String getFileName() {
    return _fileProperties.name!;
  }

  String getMimeType() {
    return _fileProperties.mimeType!;
  }

  String getFileSize() {
    return _fileProperties.size!;
  }

  String getFilePath() {
    throw UnimplementedError();
  }

  // int getProgressPercentage() {
  //   return getResponseBody()['progress'];
  // }

  @override
  String toString() => 'AmityFileInfo(_fileProperties: $_fileProperties)';
}

class AmityFile extends AmityFileInfo {
  AmityFile(AmityFileProperties fileProperties) : super(fileProperties);
}

class AmityImage extends AmityFileInfo {
  AmityImage(AmityFileProperties fileProperties) : super(fileProperties);

  String getUrl(AmityImageSize size) {
    return '${getFileUrl()}?size=${size.value}';
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

class AmityVideo extends AmityFileInfo {
  AmityVideo(AmityFileProperties fileProperties) : super(fileProperties);
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

class AmityAudio extends AmityFileInfo {
  AmityAudio(AmityFileProperties fileProperties) : super(fileProperties);
}
