enum AmityStoryDataType {
  IMAGE,
  VIDEO,
  UNKNOWN,
}

extension AmityStoryDataTypeExtension on AmityStoryDataType {
  String get value {
    return AmityStoryDataType.values[index].name.toLowerCase();
  }


  static AmityStoryDataType enumOf(String value) {
    return AmityStoryDataType.values.firstWhere(
      (element) => element.name.toLowerCase() == value.toLowerCase(),
      orElse: () => AmityStoryDataType.UNKNOWN,
    );
  }
}