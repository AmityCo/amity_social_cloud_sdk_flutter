

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class AmityGlobalFeedQuery {
  final GetGlobalFeedUsecase _usecase;
  AmityGlobalFeedQuery(this._usecase);

  Future<Tuple2<List<AmityPost>, String>> getPagingData(
      {String? token, int? limit}) async {
    GetGlobalFeedRequest request = GetGlobalFeedRequest();

    if (token != null) {
      request.token = token;
    }
    if (limit != null) {
      request.limit = limit;
    }

    final _data = await _usecase.get(request);

    return _data;
  }

  Stream<Tuple2<List<AmityPost>, String>> getPagingDataStream(
      {String? token, int? limit}) {
    GetGlobalFeedRequest request = GetGlobalFeedRequest();

    if (token != null) {
      request.token = token;
    }
    if (limit != null) {
      request.limit = limit;
    }

    return _usecase.listen(request);
  }
}
