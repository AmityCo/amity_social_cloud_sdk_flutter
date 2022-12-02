// ignore_for_file: unused_field

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/public/public.dart';

class AmityPostGetTargetSelector {
  late PostGetUsecase _useCase;
  AmityPostGetTargetSelector({required PostGetUsecase useCase}) {
    _useCase = useCase;
  }

  AmityPostGetQueryBuilder targetMe() {
    return AmityPostGetQueryBuilder(
        _useCase, AmityCoreClient.getUserId(), AmityPostTargetType.USER.value);
  }

  AmityPostGetQueryBuilder targetUser(String targetUser) {
    return AmityPostGetQueryBuilder(
        _useCase, targetUser, AmityPostTargetType.USER.value);
  }

  AmityPostGetQueryBuilder targetCommunity(String communityId) {
    return AmityPostGetQueryBuilder(
        _useCase, communityId, AmityPostTargetType.COMMUNITY.value);
  }
}

class AmityPostGetQueryBuilder {
  final PostGetUsecase _useCase;
  final String _targetId;
  final String _targetType;
  final GetPostRequest _request;

  String? _sortOption = AmityPostSortOption.LAST_CREATED.apiKey;
  bool? _hasFlag;
  bool? _isDeleted = false; //Default Value false
  String? _amityFeedType;
  List<String>? _dataTypes;
  List<String>? _tags;

  AmityPostGetQueryBuilder(this._useCase, this._targetId, this._targetType)
      : _request = GetPostRequest(targetId: _targetId, targetType: _targetType);

  AmityPostGetQueryBuilder sortBy(AmityPostSortOption sortOption) {
    _sortOption = sortOption.apiKey;
    return this;
  }

  AmityPostGetQueryBuilder includeDeleted(bool includeDeleted) {
    _isDeleted = includeDeleted;
    return this;
  }

  AmityPostGetQueryBuilder hasFlag(bool hasFlag) {
    _hasFlag = hasFlag;
    return this;
  }

  AmityPostGetQueryBuilder feedType(AmityFeedType feedType) {
    _amityFeedType = feedType.value;
    return this;
  }

  AmityPostGetQueryBuilder types(List<AmityDataType> postTypes) {
    _dataTypes = postTypes.map((e) => e.value).toList();
    return this;
  }

  AmityPostGetQueryBuilder tags(List<String> tags) {
    _tags = tags;
    return this;
  }

  AmityPostGetQueryBuilder onlyParent(bool onlyParent) {
    _request.matchingOnlyParentPost = onlyParent;
    return this;
  }

  Future<PageListData<List<AmityPost>, String>> getPagingData(
      {String? token, int? limit}) async {
    if (_sortOption != null) _request.sortBy = _sortOption;
    if (_hasFlag != null) _request.hasFlag = _hasFlag;
    if (_isDeleted != null) _request.isDeleted = _isDeleted;
    if (_amityFeedType != null) _request.feedType = _amityFeedType;
    if (_dataTypes != null && _dataTypes!.isNotEmpty) {
      _request.dataTypes = _dataTypes;

      //Disable matchOnlyParent filtering, because all parent post is text only.
      _request.matchingOnlyParentPost = false;
    }

    if (_tags != null && _tags!.isNotEmpty) {
      _request.tags = _tags;
    }

    _request.options = OptionsRequest();

    if (token != null) {
      _request.options!.token = token;
    }
    if (limit != null) {
      _request.options!.limit = limit;
    }

    final data = await _useCase.get(_request);

    return data;
  }
}
