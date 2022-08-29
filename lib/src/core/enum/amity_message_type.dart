// ignore_for_file: constant_identifier_names
/// [AmityMessageDataType]
enum AmityMessageDataType { TEXT, IMAGE, FILE, AUDIO, CUSTOM }

/// [AmityMessageDataType] Extension
extension AmityMessageDataTypeExtension on AmityMessageDataType {
  /// Value
  String get value {
    return AmityMessageDataType.values[index].name.toLowerCase();
  }

  /// Enum Of
  //TODO - this method need to acceesable with AmityDataType
  static AmityMessageDataType enumOf(String value) {
    return AmityMessageDataType.values.firstWhere(
      (element) => element.name.toLowerCase() == value.toLowerCase(),
      orElse: () => AmityMessageDataType.TEXT,
    );
  }
}
