import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/core/enum/amity_user_feed_sort_option.dart';
import 'package:amity_sdk/core/model/api_request/get_community_feed_request.dart';
import 'package:amity_sdk/core/model/api_request/core/option_request.dart';
import 'package:amity_sdk/core/utils/tuple.dart';
import 'package:amity_sdk/domain/domain.dart';
import 'package:amity_sdk/domain/usecase/feed/get_community_feed_usecase.dart';

class CommunityFeedQueryBuilder {
  final GetCommunityFeedUsecase _usecase;
  late GetCommunityFeedRequest _request;

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
    // _request.dataTypes = types.map((e) => e.value).toList();
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
