
import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/public/public.dart';

class AmityFeedGetTargetSelector{
  late PostGetUsecase _useCase;
  AmityFeedGetTargetSelector({required PostGetUsecase useCase}) {
    _useCase = useCase;
  }

  AmityFeedGetQureyBuilder targetMe() {
    return AmityFeedGetQureyBuilder(_useCase, AmityCoreClient.getUserId(), AmityPostTargetType.USER.value);
  }

  AmityFeedGetQureyBuilder targetUser(String targetUser) {
    return AmityFeedGetQureyBuilder(_useCase, targetUser, AmityPostTargetType.USER.value);
  }

  AmityFeedGetQureyBuilder targetCommunity(String communityId) {
    return AmityFeedGetQureyBuilder(_useCase, communityId, AmityPostTargetType.COMMUNITY.value);
  }
}

class AmityFeedGetQureyBuilder{
  final PostGetUsecase _useCase;
  final String _targetId;
  final String _targetType;
  final GetPostRequest _request;


  String? _sortOption = AmityUserFeedSortOption.LAST_CREATED.value;
  bool? _hasFlag;
  bool? _isDeleted = false; //Default Value false
  String? _amityFeedType;
  List<String>? _dataTypes;
  List<String>? _tags;


  AmityFeedGetQureyBuilder(this._useCase, this._targetId, this._targetType)
      : _request = GetPostRequest(targetId: _targetId, targetType: _targetType);

  AmityFeedGetQureyBuilder sortBy(AmityUserFeedSortOption sortOption) {
    _sortOption = sortOption.value;
    return this;
  }

  AmityFeedGetQureyBuilder includeDeleted(bool includeDeleted) {
    _isDeleted = includeDeleted;
    return this;
  }

  AmityFeedGetQureyBuilder hasFlag(bool hasFlag) {
    _hasFlag = hasFlag;
    return this;
  }

  AmityFeedGetQureyBuilder feedType(AmityFeedType feedType) {
    _amityFeedType = feedType.value;
    return this;
  }

  AmityFeedGetQureyBuilder types(List<AmityDataType> postTypes) {
    _dataTypes = postTypes.map((e) => e.value).toList();
    return this;
  }

  AmityFeedGetQureyBuilder tags(List<String> tags) {
    _tags = tags;
    return this;
  }

  AmityFeedGetQureyBuilder onlyParent(bool onlyParent) {
    _request.matchingOnlyParentPost = onlyParent;
    return this;
  }

  Future<PageListData<List<AmityPost>, String>> getPagingData({String? token, int? limit}) async {
    if (_sortOption != null) _request.sortBy = _sortOption;
    if (_hasFlag != null) _request.hasFlag = _hasFlag;
    if (_amityFeedType != null) _request.feedType = _amityFeedType;

    _request.isDeleted = _isDeleted ?? true ? null : false;

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