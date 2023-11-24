// ignore_for_file: constant_identifier_names

enum AmityDataType { TEXT, IMAGE, VIDEO, FILE, LIVESTREAM, POLL, CUSTOM }

extension AmityDataTypeExtension on AmityDataType {
  String get value {
    return AmityDataType.values[index].name.toLowerCase();
  }

  //TODO - this method need to acceesable with AmityDataType
  static AmityDataType enumOf(String value) {
    return AmityDataType.values.firstWhere(
      (element) => element.name.toLowerCase() == value.toLowerCase(),
      orElse: () => AmityDataType.TEXT,
    );
  }
}
