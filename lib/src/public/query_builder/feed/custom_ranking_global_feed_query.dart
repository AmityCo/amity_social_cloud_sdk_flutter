import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/usecase/feed/get_custom_ranking_usecase.dart';

class AmityCustomRankingGlobalFeedQuery{
  final GetCustomRankingUseCase _usecase;

  AmityCustomRankingGlobalFeedQuery(this._usecase); 

  Future<PageListData<List<AmityPost>, String>> getPagingData(
      {String? token, int? limit}) async {
    GetGlobalFeedRequest request = GetGlobalFeedRequest();

    if (token != null) {
      request.token = token;
    }
    if (limit != null) {
      request.limit = limit;
    }

    final data = await _usecase.get(request);

    return data;
  }


}