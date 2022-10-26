// ignore_for_file: constant_identifier_names, public_member_api_docs

enum AmityChannelFilter { ALL, MEMBER, NOT_MEMBER }

extension AmityChannelFilterExtension on AmityChannelFilter {
  String get value {
    // return AmityChannelFilter.values[index].name.toLowerCase();
    return [
      'all',
      'member',
      'notMember',
    ][index];
  }

  //TODO: - this method need to acceesable with AmityCommentReferenceType :)
  static AmityChannelFilter enumOf(String value) {
    return AmityChannelFilter.values.firstWhere(
      (element) => element.name.toLowerCase() == value.toLowerCase(),
      orElse: () => AmityChannelFilter.ALL,
    );
  }
}
