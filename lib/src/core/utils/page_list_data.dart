// ignore_for_file: unnecessary_overrides

class PageListData<T1, T2> {
  /// Returns the first item of the tuple
  final T1 data;

  /// Returns the second item of the tuple
  final T2 token;

  /// Creates a new tuple value with the specified items.
  const PageListData(this.data, this.token);

  /// Create a new tuple value with the specified list [items].
  factory PageListData.fromList(List items) {
    if (items.length != 2) {
      throw ArgumentError('items must have length 2');
    }

    return PageListData<T1, T2>(items[0] as T1, items[1] as T2);
  }

  /// Returns a tuple with the first item set to the specified value.
  PageListData<T1, T2> withItem1(T1 v) => PageListData<T1, T2>(v, token);

  /// Returns a tuple with the second item set to the specified value.
  PageListData<T1, T2> withItem2(T2 v) => PageListData<T1, T2>(data, v);

  /// Creates a [List] containing the items of this [PageListData].
  ///
  /// The elements are in item order. The list is variable-length
  /// if [growable] is true.
  List toList({bool growable = false}) =>
      List.from([data, token], growable: growable);

  @override
  String toString() => '[$data, $token]';

  @override
  bool operator ==(Object other) =>
      other is PageListData && other.data == data && other.token == token;

  @override
  int get hashCode => super.hashCode;

  // @override
  // int get hashCode => hash2(item1.hashCode, item2.hashCode);
}
