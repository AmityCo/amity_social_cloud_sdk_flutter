import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/enum/amity_community_filter.dart';
import 'package:amity_sdk/src/core/enum/amity_community_sort_option.dart';
import 'package:amity_sdk/src/domain/usecase/community/community_get_query_usecase.dart';

class CommunityGetQueryBuilder {
  final CommunityGetQueryUseCase useCase;

  String? _keyword;
  String? _categoryId;
  AmityCommunityFilter _filter = AmityCommunityFilter.ALL;
  AmityCommunitySortOption _sortBy = AmityCommunitySortOption.DISPLAY_NAME;
  bool? _isDeleted;

  CommunityGetQueryBuilder({required this.useCase});

  CommunityGetQueryBuilder withKeyword(String? keyword) {
    _keyword = keyword;
    return this;
  }

  CommunityGetQueryBuilder categoryId(String categoryId) {
    _categoryId = categoryId;
    return this;
  }

  CommunityGetQueryBuilder filter(AmityCommunityFilter filter) {
    _filter = filter;
    return this;
  }

  CommunityGetQueryBuilder sortBy(AmityCommunitySortOption sortBy) {
    _sortBy = sortBy;
    return this;
  }

  CommunityGetQueryBuilder includeDeleted(bool includeDeleted) {
    _isDeleted = includeDeleted;
    return this;
  }

  Future<Tuple2<List<AmityCommunity>, String>> getPagingData(
      {String? token, int? limit}) async {
    GetCommunityRequest _request = GetCommunityRequest();

    _request.keyword = _keyword;
    _request.categoryId = _categoryId;
    _request.filter = _filter.value;
    _request.sortBy = _sortBy.apiKey;
    _request.isDeleted = _isDeleted;

    _request.options = OptionsRequest();
    if (token != null) {
      _request.options!.token = token;
    }
    if (limit != null) {
      _request.options!.limit = limit;
    }

    final _data = await useCase.get(_request);

    return _data;
  }
}
