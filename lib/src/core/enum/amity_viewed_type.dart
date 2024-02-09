enum AmityViewedType {
  POST,
  STORY,
}

extension AmityViewedTypeExtension on AmityViewedType {
  String get apiKey {
    return AmityViewedType.values[index].name.toLowerCase();
  }

  static AmityViewedType enumOf(String value) {
    return AmityViewedType.values.firstWhere(
      (element) => element.name.toLowerCase() == value.toLowerCase(),
      orElse: () => AmityViewedType.POST,
    );
  }
}