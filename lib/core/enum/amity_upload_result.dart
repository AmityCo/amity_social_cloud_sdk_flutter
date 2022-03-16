enum AmityUploadResult { PROGRESS, COMPLETE, ERROR, CANCELLED }

extension AmityUploadResultExtension on AmityUploadResult {
  String get value {
    return AmityUploadResult.values[index].name.toLowerCase();
  }

  //TODO - this method need to acceesable with AmityDataType
  static AmityUploadResult enumOf(String value) {
    return AmityUploadResult.values.firstWhere(
      (element) => element.name.toLowerCase() == value.toLowerCase(),
      orElse: () => AmityUploadResult.CANCELLED,
    );
  }
}
