enum AmityStoryImageDisplayMode {
  FIT,
  FILL,
}

extension AmityStoryImageDisplayModeExtension on AmityStoryImageDisplayMode {
  String get value {
    return AmityStoryImageDisplayMode.values[index].name.toLowerCase();
  }


  static AmityStoryImageDisplayMode enumOf(String value) {
    return AmityStoryImageDisplayMode.values.firstWhere(
      (element) => element.name.toLowerCase() == value.toLowerCase(),
      orElse: () => AmityStoryImageDisplayMode.FILL,
    );
  }
}