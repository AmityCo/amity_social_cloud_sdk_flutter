enum AmityQuerySortingOrder { ASC, DESC }

extension AmityQuerySortingOrderExtension on AmityQuerySortingOrder {
  String get sqlOrder {
    return ['asc', 'desc'][index];
  }
}
