// ignore_for_file: constant_identifier_names

enum AmityFeedType {
  PUBLISHED,
  REVIEWING,
  DECLINED,
}

extension AmityFeedTypeExtension on AmityFeedType {
  String get value {
    return AmityFeedType.values[index].name.toLowerCase();
  
  }


  static AmityFeedType enumOf(String value) {
    return AmityFeedType.values.firstWhere(
      (element) => element.name.toLowerCase() == value.toLowerCase(),
      orElse: () => AmityFeedType.PUBLISHED,
    );
  }

}
