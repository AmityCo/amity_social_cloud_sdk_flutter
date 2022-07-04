import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class CommunityCategoryGetQueryBuilder {
  CommunityCategoryQueryUsecase usecase;
  final GetCommunityCategoryRequest _request;

  CommunityCategoryGetQueryBuilder({required this.usecase})
      : _request = GetCommunityCategoryRequest(
            sortBy: AmityCommunityCategorySortOption.NAME.value);

  CommunityCategoryGetQueryBuilder includeDeleted(bool includeDeleted) {
    _request.isDeleted = includeDeleted;
    return this;
  }

  CommunityCategoryGetQueryBuilder sortBy(
      AmityCommunityCategorySortOption sortOption) {
    _request.sortBy = sortOption.value;
    return this;
  }

  Future<PageListData<List<AmityCommunityCategory>, String>> getPagingData(
      {String? token, int? limit}) async {
    _request.options = OptionsRequest();

    if (token != null) {
      _request.options!.token = token;
    }
    if (limit != null) {
      _request.options!.limit = limit;
    }

    final data = await usecase.get(_request);

    return data;
  }
}
