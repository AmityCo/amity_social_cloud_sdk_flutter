enum AmityContentFeedType{
  STORY,
  POST,
  MESSAGE,
  CLIP
}


extension AmityContentFeedTypeExtension on AmityContentFeedType {
  String get value {
    return AmityContentFeedType.values[index].name.toLowerCase();
  }


  static AmityContentFeedType enumOf(String value) {
    return AmityContentFeedType.values.firstWhere(
      (element) => element.name.toLowerCase() == value.toLowerCase(),
      orElse: () => AmityContentFeedType.POST,
    );
  }
}