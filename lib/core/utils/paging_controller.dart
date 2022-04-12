import 'package:amity_sdk/core/utils/tuple.dart';
import 'package:flutter/foundation.dart';

typedef PageFuture<T> = Future<Tuple2<List<T>, String>> Function(String? token);

class PagingController<T> extends ChangeNotifier {
  PagingController({required this.pageFuture, this.pageSize = 10});

  List<T> _loadedItems = [];
  List<T> _lastLoadedItems = [];

  String? _nextPageToken;
  int _numberOfLoadedPages = 0;

  bool _hasMoreItems = true;
  Object? _error;
  bool _isFetching = false;

  /// Called whenever a new page (or batch) is to be fetched
  ///
  /// It is provided with the page index, and expected to return a [Future](https://api.dartlang.org/stable/1.24.3/dart-async/Future-class.html) that
  /// resolves to a list of entries. Please make sure to return only [pageSize]
  /// or less entries (in the case of the last page) for each page.
  final PageFuture<T> pageFuture;

  /// The number  of entries per page
  final int pageSize;

  /// The list of items that have already been loaded
  List<T> get loadedItems => _loadedItems;

  /// The number of pages that have already been loaded
  int get numberOfLoadedPages => _numberOfLoadedPages;

  /// Whether there are still more items to load
  bool get hasMoreItems => _hasMoreItems;

  /// The latest error that has been faced when trying to load a page
  Object? get error => _error;

  /// set to true if no data was found
  bool? get noItemsFound => _loadedItems.isEmpty && hasMoreItems == false;

  bool get isFetching => _isFetching;

  /// Called to initialize the controller. Same as [reset]
  void init() {
    reset();
  }

  /// Resets all the information of the controller
  void reset() {
    _lastLoadedItems = [];
    _loadedItems = [];
    _numberOfLoadedPages = 0;
    _hasMoreItems = true;
    _error = null;
    _isFetching = false;
    _nextPageToken = null;
    notifyListeners();
  }

  void add(T item) {
    _loadedItems.add(item);
    notifyListeners();
  }

  void addAtIndex(int index, T item) {
    _loadedItems.insert(index, item);
    notifyListeners();
  }

  void remove(T item) {
    _loadedItems.remove(item);
    notifyListeners();
  }

  /// Fetches a new page by calling [pageFuture]
  Future<void> fetchNextPage() async {
    if (!_isFetching) {
      _isFetching = true;
      notifyListeners();
      List<T>? page;
      try {
        final data = await pageFuture(_nextPageToken);
        page = data.item1;
        _nextPageToken = data.item2;
        _numberOfLoadedPages++;
      } catch (error, stacktrace) {
        print(error.toString());
        print(stacktrace.toString());
        _error = error;
        _isFetching = false;
        page = [];
        notifyListeners();
        return;
      }

      // Get length accounting for possible null Future return. We'l treat a null Future as an empty return
      final length = page.length;

      if (length > pageSize) {
        _isFetching = false;
        throw Exception(
            'Page length ($length) is greater than the maximum size ($pageSize)');
      }

      if (length > 0 && length < pageSize) {
        //   // This should only happen when loading the last page.
        //   // In that case, we append the last page with a few items to make its size
        //   // similar to normal pages. This is useful especially with GridView,
        //   // because we want the loading to show on a new line on its own
        ///Last page condition
        // _lastLoadedItems = List.generate(pageSize - length, (value) => {});
        _hasMoreItems = false;
      }

      if (length == 0) {
        _hasMoreItems = false;
      } else {
        _lastLoadedItems = page;
        _loadedItems.addAll(page);
      }

      _isFetching = false;

      notifyListeners();
    }
  }

  /// Attempts to retry in case an error occurred
  void retry() {
    _error = null;
    notifyListeners();
  }
}
