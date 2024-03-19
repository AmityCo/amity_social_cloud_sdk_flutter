enum AmityStorySortingOrder { FIRST_CREATED, LAST_CREATED }

extension AmityStorySortingOrderExtension on AmityStorySortingOrder {
  String get value {
    return ['asc', 'desc'][index];
  }
}

