import 'dart:async';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// [AmityGlobalFeedQuery]
class AmityGlobalFeedQuery {
  final GetGlobalFeedUsecase _usecase;

  /// Post data type
  List<String>? _dataTypes;

  /// Init [AmityGlobalFeedQuery]
  AmityGlobalFeedQuery(this._usecase);

  AmityGlobalFeedQuery types(List<AmityDataType> postTypes) {
    _dataTypes = postTypes.map((e) => e.value).toList();
    return this;
  }

  Future<PageListData<List<AmityPost>, String>> getPagingData(
      {String? token, int? limit}) async {
    GetGlobalFeedRequest request = GetGlobalFeedRequest();

    if (token != null) {
      request.token = token;
    }
    if (limit != null) {
      request.limit = limit;
    }

    if (_dataTypes != null) {
      request.dataTypes = _dataTypes;
    }

    final data = await _usecase.get(request);

    return data;
  }

  StreamController<PageListData<List<AmityPost>, String>> getPagingDataStream(
      {String? token, int? limit}) {
    GetGlobalFeedRequest request = GetGlobalFeedRequest();

    if (token != null) {
      request.token = token;
    }
    if (limit != null) {
      request.limit = limit;
    }

    if (_dataTypes != null) {
      request.dataTypes = _dataTypes;
    }

    return _usecase.listen(request);
  }
}
