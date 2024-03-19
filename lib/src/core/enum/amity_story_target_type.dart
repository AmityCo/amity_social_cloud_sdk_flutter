enum AmityStoryTargetType {
  COMMUNITY,
  UNKNOWN,
  USER,
}

extension AmityStoryTargetTypeExtension on AmityStoryTargetType {
  String get value {
    return AmityStoryTargetType.values[index].name.toLowerCase();
  }


  static AmityStoryTargetType enumOf(String value) {
    return AmityStoryTargetType.values.firstWhere(
      (element) => element.name.toLowerCase() == value.toLowerCase(),
      orElse: () => AmityStoryTargetType.UNKNOWN,
    );
  }
}