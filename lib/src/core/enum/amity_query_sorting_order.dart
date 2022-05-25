// ignore_for_file: constant_identifier_names

enum AmityQuerySortingOrder { ASC, DESC }

extension AmityQuerySortingOrderExtension on AmityQuerySortingOrder {
  String get sqlOrder {
    return ['asc', 'desc'][index];
  }
}
