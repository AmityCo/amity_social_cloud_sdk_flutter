import 'dart:async';

import 'package:amity_sdk/src/core/core.dart';

/// Live Collection Abs layer
abstract class LiveCollection<Model> {
  /// Current Token (Next page token)
  String? currentToken;

  /// if live collection fetching next page
  bool isFetching = false;

  /// Check if first page is loaded
  bool _isFirstPage = true;

  /// get the next page request
  Future<PageListData<List<Model>, String>> getNextPageRequest(String? token);

  /// get the first page request( with out token)
  Future<PageListData<List<Model>, String>> getFirstPageRequest();

  /// Listen to live collection
  StreamController<List<Model>> getStreamController();

  /// On Error Callback
  Function(Object? error, StackTrace stackTrace)? _onErrorCallback;

  /// OnError
  void onError(Function(Object? error, StackTrace stackTrace) onErrorCallback) {
    _onErrorCallback = onErrorCallback;
  }

  /// Load next page for live collection
  Future loadNext() async {
    if (!isFetching) {
      isFetching = true;
      if (_isFirstPage) {
        return await getFirstPageRequest().then((value) {
          currentToken = value.token;
          isFetching = false;
          _isFirstPage = false;
        }).onError((error, stackTrace) {
          if (_onErrorCallback != null) {
            _onErrorCallback!(error, stackTrace);
          }
        });
      } else {
        return await getNextPageRequest(currentToken).then((value) {
          currentToken = value.token;
          isFetching = false;
          _isFirstPage = false;
        }).onError((error, stackTrace) {
          if (_onErrorCallback != null) {
            _onErrorCallback!(error, stackTrace);
          }
        });
      }
    }
  }

  /// Check if live collection have next page
  bool hasNextPage() {
    final hasNextToken =
        currentToken != null && (currentToken ?? '').isNotEmpty;
    return hasNextToken && !_isFirstPage;
  }

  /// Reset the live collection
  bool reset() {
    currentToken = null;
    isFetching = false;
    _isFirstPage = true;
    return true;
  }
}
