import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// Get Channel Query Builder
class GetChannelQueryBuilder {
  /// Channel Query Usecase
  final ChannelGetQueryUseCase useCase;

  /// Init [GetChannelQueryBuilder]
  GetChannelQueryBuilder(this.useCase);

  String? _keyword;
  AmityChannelFilter _filter = AmityChannelFilter.ALL;
  List<AmityChannelType> _types = <AmityChannelType>[];
  AmityChannelSortOption _sortBy = AmityChannelSortOption.LAST_ACTIVITY;
  bool? _isDeleted;
  List<String>? _tags;
  List<String>? _excludingTags;

  /// Search the channel with keyword
  GetChannelQueryBuilder withKeyword(String? keyword) {
    _keyword = keyword;
    return this;
  }

  /// Filter the channel with Amity Channel membership type
  GetChannelQueryBuilder filter(AmityChannelFilter filter) {
    _filter = filter;
    return this;
  }

  /// Filter the channel with channel type
  GetChannelQueryBuilder types(List<AmityChannelType> types) {
    _types = types;
    return this;
  }

  /// Filter the conversation type channel
  GetChannelQueryBuilder conversationType() {
    _types = [AmityChannelType.CONVERSATION];
    _filter = AmityChannelFilter.MEMBER;
    return this;
  }

  /// Filter the broadcast type channel
  GetChannelQueryBuilder broadcastType() {
    _types = [AmityChannelType.BROADCAST];
    return this;
  }

  /// Filter the community type channel
  GetChannelQueryBuilder communityType() {
    _types = [AmityChannelType.COMMUNITY];
    return this;
  }

  /// Filter the live type channel
  GetChannelQueryBuilder liveType() {
    _types = [AmityChannelType.LIVE];
    _filter = AmityChannelFilter.MEMBER;
    return this;
  }

  /// Sort the filtered channel
  GetChannelQueryBuilder sortBy(AmityChannelSortOption sortBy) {
    _sortBy = sortBy;
    return this;
  }

  /// Include the deleted channel in search result
  GetChannelQueryBuilder includeDeleted(bool includeDeleted) {
    _isDeleted = includeDeleted;
    return this;
  }

  /// Search the channel which include the tags
  GetChannelQueryBuilder includingTags(List<String> tags) {
    _tags = tags;
    return this;
  }

  /// Search the channel which exclude the tags
  GetChannelQueryBuilder excludingTags(List<String> tags) {
    _excludingTags = tags;
    return this;
  }

  /// Get the paginated data for channel query
  Future<PageListData<List<AmityChannel>, String>> getPagingData(
      {String? token, int? limit}) async {
    GetChannelRequest request = GetChannelRequest();

    request.keyword = _keyword;
    request.filter = _filter.value;
    request.types = _types.map((e) => e.value).toList();
    request.sortBy = _sortBy.value;
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
    if (_excludingTags != null && _excludingTags!.isNotEmpty) {
      request.excludeTags = _excludingTags;
    }

    final data = await useCase.get(request);

    return data;
  }
}
