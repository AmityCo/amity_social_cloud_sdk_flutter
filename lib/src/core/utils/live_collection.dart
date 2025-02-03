import 'dart:async';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/extension/stream_controller_extendion.dart';
import 'package:amity_sdk/src/core/utils/amity_nonce.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/data/data_source/data_source.dart';
import 'package:amity_sdk/src/domain/usecase/paging/paging_id_insert_usecase.dart';
import 'package:flutter/foundation.dart';

typedef RequestBuilder<T> = T Function();

/// Live Collection Abs layer
abstract class LiveCollection<Model> {
  /// Current Token (Next page token)
  String? currentToken;

  /// if live collection fetching next page
  bool isFetching = false;

  /// Check if first page is loaded
  bool _isFirstPage = true;

  final defaultPageSize = 20;

  @protected
  /// get the next page request
  Future<PageListData<List<Model>, String>> getNextPageRequestInternal(String? token);

  @protected
  /// get the next page request
  Future<PageListData<List<Model>, String>> getNextPageRequest(String? token) {
    return getNextPageRequestInternal(token);
  }

  @protected
  /// get the first page request( with out token)
  Future<PageListData<List<Model>, String>> getFirstPageRequest();

  /// Listen to live collection
  StreamController<List<Model>> getStreamController();

  final StreamController<bool> _loadingStateStream = StreamController<bool>();

  StreamController<PagingIdHiveEntity>? interactorStream;

  /// On Error Callback
  Function(Object? error, StackTrace stackTrace)? _onErrorCallback;

  /// OnError
  void onError(Function(Object? error, StackTrace stackTrace) onErrorCallback) {
    _onErrorCallback = onErrorCallback;
  }

  LiveCollection() {
    _loadingStateStream.add(true);
    _startInteractor();
  }

  /// Load next page for live collection
  Future loadNext() async {
    if(!_isFirstPage && !hasNextPage()) {
      return;
    }

    if (!isFetching) {
      isFetching = true;
      _loadingStateStream.add(true);
      _loadingStateStream.addData(true);
      if (_isFirstPage) {
        return await getFirstPageRequest().then((value) {
          currentToken = value.token;
          isFetching = false;
          _loadingStateStream.addData(false);
          _isFirstPage = false;
        }).onError((error, stackTrace) {
          isFetching = false;
          _loadingStateStream.addData(false);
          _isFirstPage = false;
          if (_onErrorCallback != null) {
            _onErrorCallback!(error, stackTrace);
          }
        });
      } else {
        return await getNextPageRequestInternal(currentToken).then((value) {
          currentToken = value.token;
          isFetching = false;
          _loadingStateStream.addData(false);
          _isFirstPage = false;
        }).onError((error, stackTrace) {
          isFetching = false;
          _loadingStateStream.addData(false);
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
    _loadingStateStream.addData(false);
    return true;
  }

  /// Observe Loading State
  Stream<bool> observeLoadingState() {
    return _loadingStateStream.stream;
  }

  @protected
  StreamController<PagingIdHiveEntity> observeNewItem() {
    return StreamController();
  }

  void _startInteractor() {
    interactorStream = observeNewItem();
    interactorStream?.stream.listen((pagingId) async {
      await serviceLocator<PagingIdInsertUsecase>().process(pagingId);
    });
  }

  AmityNonce getNonce() {
    return AmityNonce.UNKNOWN;
  }

  int getHash() {
    return 0;
  }

  Future<void> dispose() async {
    await _loadingStateStream.close();
    await interactorStream?.close();
    return getStreamController().close();
  }
}
