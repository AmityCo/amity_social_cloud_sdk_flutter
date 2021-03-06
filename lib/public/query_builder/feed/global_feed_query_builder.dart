import 'package:amity_sdk/core/model/api_request/get_global_feed_request.dart';
import 'package:amity_sdk/core/utils/tuple.dart';
import 'package:amity_sdk/domain/model/amity_post.dart';
import 'package:amity_sdk/domain/usecase/feed/get_global_feed_usecase.dart';

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
