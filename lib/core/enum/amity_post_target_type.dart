// ignore_for_file: constant_identifier_names
enum AmityPostTargetType { USER, COMMUNITY }

extension AmityPostTargetTypeExtension on AmityPostTargetType {
  // String get value {
  //   return [
  //     'user',
  //     'community',
  //   ][index];
  // }

  String get value {
    return AmityPostTargetType.values[index].name.toLowerCase();
  }

  //TODO - this method need to acceesable with AmityDataType
  static AmityPostTargetType enumOf(String value) {
    return AmityPostTargetType.values.firstWhere(
      (element) => element.name.toLowerCase() == value.toLowerCase(),
      orElse: () => AmityPostTargetType.USER,
    );
  }
}
