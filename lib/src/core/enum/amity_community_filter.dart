// ignore_for_file: constant_identifier_names

enum AmityCommunityFilter { ALL, MEMBER, NOT_MEMBER }

extension AmityCommunityFilterExtension on AmityCommunityFilter {
  String get value {
    // return AmityCommunityFilter.values[index].name.toLowerCase();
    return [
      'all',
      'member',
      'notMember',
    ][index];
  }

  //TODO: - this method need to acceesable with AmityCommentReferenceType :)
  static AmityCommunityFilter enumOf(String value) {
    return AmityCommunityFilter.values.firstWhere(
      (element) => element.name.toLowerCase() == value.toLowerCase(),
      orElse: () => AmityCommunityFilter.ALL,
    );
  }
}
