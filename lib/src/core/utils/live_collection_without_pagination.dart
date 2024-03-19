import 'dart:async';

/// Live Collection Abs layer
abstract class LiveCollectionWithoutPagination<Model> {
  /// if live collection fetching next page
  bool isFetching = false;

  /// get the first page request( with out token)
  Future<List<Model>> getData();

  /// Listen to live collection
  StreamController<List<Model>> getStreamController();

  /// On Error Callback
  Function(Object? error, StackTrace stackTrace)? _onErrorCallback;

  /// OnError
  void onError(Function(Object? error, StackTrace stackTrace) onErrorCallback) {
    _onErrorCallback = onErrorCallback;
  }

  /// Load next page for live collection
  Future load() async {
    if (!isFetching) {
      isFetching = true;
      return await getData().then((value) {
        isFetching = false;
      }).onError((error, stackTrace) {
        if (_onErrorCallback != null) {
          _onErrorCallback!(error, stackTrace);
        }
      });
    }
  }

  /// Reset the live collection
  bool reset() {
    isFetching = false;
    return true;
  }
}
