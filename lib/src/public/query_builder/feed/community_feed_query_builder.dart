import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class CommunityFeedQueryBuilder {
  final GetCommunityFeedUsecase _usecase;
  late final GetCommunityFeedRequest _request;

  CommunityFeedQueryBuilder(this._usecase, String communityId)
      : _request = GetCommunityFeedRequest(communityId: communityId);

  CommunityFeedQueryBuilder includeDeleted(bool flag) {
    _request.isDeleted = flag;
    return this;
  }

  CommunityFeedQueryBuilder types(List<AmityDataType> types) {
    _request.dataTypes = types.map((e) => e.value).toList();
    return this;
  }

  CommunityFeedQueryBuilder feedType(AmityFeedType feedType) {
    return this;
  }

  CommunityFeedQueryBuilder sortBy(AmityUserFeedSortOption sortOption) {
    _request.sortBy = sortOption.value;
    return this;
  }

  Future<Tuple2<List<AmityPost>, String>> getPagingData(
      {String? token, int? limit}) async {
    _request.options = OptionsRequest();
    if (token != null) {
      _request.options!.token = token;
    }
    if (limit != null) {
      _request.options!.limit = limit;
    }

    final _data = await _usecase.get(_request);

    return _data;
  }
}
