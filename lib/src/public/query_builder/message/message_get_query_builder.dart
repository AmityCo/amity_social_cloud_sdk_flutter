import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// [MessageGetQueryBuilder]
class MessageGetQueryBuilder {
  /// UseCase
  late MessageQueryUseCase _useCase;

  late MessageQueryRequest _request;

  bool _stackFromEnd = true;
  String? _parentId;
  bool? _isFilterByParentId = false;
  AmityTags? _includingTags;
  AmityTags? _excludingTags;
  bool? _isDeleted;
  AmityMessageDataType? _type;

  /// [MessageGetQueryBuilder]
  MessageGetQueryBuilder(MessageQueryUseCase useCase, String channelId) {
    _useCase = useCase;
    _request = MessageQueryRequest(channelId: channelId);
  }

  /// includeDeleted
  MessageGetQueryBuilder includeDeleted(bool includeDeleted) {
    if (!includeDeleted) {
      _isDeleted = false;
    }
    return this;
  }

  MessageGetQueryBuilder type(AmityMessageDataType? type) {
    _type = type;
    return this;
  }

  /// Stack From End
  MessageGetQueryBuilder stackFromEnd(bool stackFromEnd) {
    _stackFromEnd = stackFromEnd;
    return this;
  }

  /// Parent ID
  MessageGetQueryBuilder parentId(String id) {
    _parentId = id;
    _isFilterByParentId = true;
    return this;
  }

  /// Parent ID
  MessageGetQueryBuilder filterByParent(bool filrerByParent) {
    _isFilterByParentId = filrerByParent;
    return this;
  }

  /// includingTags
  MessageGetQueryBuilder includingTags(List<String> tags) {
    _includingTags = AmityTags(tags: tags);
    return this;
  }

  /// excludingTags
  MessageGetQueryBuilder excludingTags(List<String> tags) {
    _excludingTags = AmityTags(tags: tags);
    return this;
  }

  /// getPagingData
  Future<PageListData<List<AmityMessage>, String>> getPagingData(
      {String? token, int? limit = 20}) async {
    final data =
        await _useCase.get(build(pageSize: limit)..options!.token = token);

    return data;
  }

  /// Get Live collection for the messages
  MessageLiveCollection getLiveCollection({int? pageSize = 20}) {
    return MessageLiveCollection(
      request: () => build(pageSize: pageSize),
    );
  }

  /// Build request
  MessageQueryRequest build({int? pageSize = 20}) {
    if (_isDeleted != null) _request.isDeleted = _isDeleted;
    if (_parentId != null) {
      _request.parentId = _parentId;
      _request.filterByParentId = true;
    }
    if (_isFilterByParentId != null) {
      _request.filterByParentId = _isFilterByParentId;
    }
    if (_type != null) _request.type = _type!.value;
    if (_includingTags != null) _request.tags = _includingTags!.tags;
    if (_excludingTags != null) _request.excludeTags = _excludingTags!.tags;

    _request.stackFromEnd = _stackFromEnd;

    _request.options = OptionsRequest();

    _request.options!.type = 'scrollable';
    if (!_stackFromEnd) {
      _request.options!.first = pageSize;
    } else {
      _request.options!.last = pageSize;
    }

    return _request;
  }

  /// Query
  Future<List<AmityMessage>> query({String? token, int? limit = 20}) async {
    final data =
        await _useCase.get(build(pageSize: limit)..options!.token = token);

    return data.data;
  }
}
