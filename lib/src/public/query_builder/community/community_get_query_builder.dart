import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/usecase/community/community_get_query_usecase.dart';

class CommunityGetQueryBuilder {
  final CommunityGetQueryUseCase useCase;

  String? _keyword;
  String? _categoryId;
  AmityCommunityFilter _filter = AmityCommunityFilter.ALL;
  AmityCommunitySortOption _sortBy = AmityCommunitySortOption.DISPLAY_NAME;
  bool? _isDeleted;
  List<String>? _tags;

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

  CommunityGetQueryBuilder tags(List<String> tags) {
    _tags = tags;
    return this;
  }

  Future<Tuple2<List<AmityCommunity>, String>> getPagingData(
      {String? token, int? limit}) async {
    GetCommunityRequest request = GetCommunityRequest();

    request.keyword = _keyword;
    request.categoryId = _categoryId;
    request.filter = _filter.value;
    request.sortBy = _sortBy.apiKey;
    request.isDeleted = _isDeleted;

    request.options = OptionsRequest();
    if (token != null) {
      request.options!.token = token;
    }
    if (limit != null) {
      request.options!.limit = limit;
    }

    if (_tags != null && _tags!.isNotEmpty) {
      request.tags = _tags;
    }

    final data = await useCase.get(request);

    return data;
  }
}
