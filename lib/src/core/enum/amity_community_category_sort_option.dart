// ignore_for_file: constant_identifier_names

enum AmityCommunityCategorySortOption { NAME, FIRST_CREATED, LAST_CREATED }

extension AmityCommunityCategorySortOptionExtension
    on AmityCommunityCategorySortOption {
  String get value {
    return [
      'name',
      'firstCreated',
      'lastCreated',
    ][index];
  }
}
