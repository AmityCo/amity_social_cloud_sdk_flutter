import 'package:amity_sdk/core/enum/amity_comment_sort_option.dart';
import 'package:amity_sdk/core/enum/amity_comment_target_type.dart';
import 'package:amity_sdk/core/model/api_request/get_comment_request.dart';
import 'package:amity_sdk/core/utils/tuple.dart';
import 'package:amity_sdk/domain/model/amity_comment.dart';
import 'package:amity_sdk/domain/usecase/comment/comment_query_usecase.dart';

class AmityCommentQueryTypeSelector {
  late CommentQueryUsecase _useCase;
  AmityCommentQueryTypeSelector({required CommentQueryUsecase useCase}) {
    _useCase = useCase;
  }
  AmityCommentQueryBuilder post(String postId) {
    return AmityCommentQueryBuilder(useCase: _useCase)
        .referenceId(postId)
        .referenceType(AmityCommentTargetType.POST.value);
  }

  AmityCommentQueryBuilder content(String contentId) {
    return AmityCommentQueryBuilder(useCase: _useCase)
        .referenceId(contentId)
        .referenceType(AmityCommentTargetType.CONTENT.value);
  }
}

class AmityCommentQueryBuilder {
  late CommentQueryUsecase _useCase;
  late String _referenceType;
  late String _referenceId;

  String? _parentId;
  bool? _isFilterByParentId;
  bool? _isDeleted;
  AmityCommentSortOption _sortOption = AmityCommentSortOption.LAST_CREATED;

  AmityCommentQueryBuilder({required CommentQueryUsecase useCase}) {
    _useCase = useCase;
  }

  AmityCommentQueryBuilder referenceType(String referenceType) {
    _referenceType = referenceType;
    return this;
  }

  AmityCommentQueryBuilder referenceId(String referenceId) {
    _referenceId = referenceId;
    return this;
  }

  AmityCommentQueryBuilder includeDeleted(bool includeDeleted) {
    if (!includeDeleted) {
      _isDeleted = false;
    }
    return this;
  }

  AmityCommentQueryBuilder parentId(String? parentId) {
    _parentId = parentId;
    _isFilterByParentId = true;
    return this;
  }

  AmityCommentQueryBuilder sortBy(AmityCommentSortOption sortOption) {
    _sortOption = sortOption;
    return this;
  }

  Future<List<AmityComment>> query() {
    GetCommentRequest getCommentRequest = GetCommentRequest(
        referenceId: _referenceId, referenceType: _referenceType);

    if (_parentId != null) {
      getCommentRequest.parentId = _parentId;
      getCommentRequest.filterByParentId = _isFilterByParentId;
    }

    if (_isDeleted != null) {
      getCommentRequest.isDeleted = _isDeleted;
    }

    getCommentRequest.sortBy = _sortOption.apiKey;

    return _useCase.get(getCommentRequest);
  }

  Future<Tuple2<List<AmityComment>, String>> getPagingData(
      {String? token, int? limit}) {
    GetCommentRequest getCommentRequest = GetCommentRequest(
        referenceId: _referenceId, referenceType: _referenceType);

    if (_parentId != null) {
      getCommentRequest.parentId = _parentId;
      getCommentRequest.filterByParentId = _isFilterByParentId;
    }

    if (_isDeleted != null) {
      getCommentRequest.isDeleted = _isDeleted;
    }

    getCommentRequest.sortBy = _sortOption.apiKey;

    Options options = Options();
    getCommentRequest.options = options;
    options.type = 'pagination'; //Default option
    if (token != null) {
      getCommentRequest.options?.token = token;
    }

    if (limit != null) {
      getCommentRequest.options?.limit = limit;
    }

    return _useCase.getPagingData(getCommentRequest);
  }
}
