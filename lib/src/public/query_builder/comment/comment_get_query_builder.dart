import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

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

  AmityCommentDataTypeFilter? dataTypeFilter;

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

  /// Get the comment with parent ID
  AmityCommentQueryBuilder parentId(String? parentId) {
    _parentId = parentId;
    return this;
  }

  AmityCommentQueryBuilder filterById(bool isFilterByParentId) {
    _isFilterByParentId = isFilterByParentId;
    return this;
  }

  /// Sort the comment by [AmityCommentSortOption]
  AmityCommentQueryBuilder sortBy(AmityCommentSortOption sortOption) {
    _sortOption = sortOption;
    return this;
  }

  AmityCommentQueryBuilder dataTypes(AmityCommentDataTypeFilter? filter) {
    dataTypeFilter = filter;
    return this;
  }

  /// Query the comment list
  Future<List<AmityComment>> query() {
    GetCommentRequest getCommentRequest = GetCommentRequest(referenceId: _referenceId, referenceType: _referenceType);

    if (_parentId != null) {
      getCommentRequest.parentId = _parentId;
    }

    if (_isDeleted != null) {
      getCommentRequest.isDeleted = _isDeleted;
    }

    getCommentRequest.sortBy = _sortOption.apiKey;

    return _useCase.get(getCommentRequest);
  }

  Future<PageListData<List<AmityComment>, String>> getPagingData({String? token, int? limit}) {
    GetCommentRequest getCommentRequest = GetCommentRequest(referenceId: _referenceId, referenceType: _referenceType);

    if (_parentId != null) {
      getCommentRequest.parentId = _parentId;
    }

    if (_isFilterByParentId != null) {
      getCommentRequest.filterByParentId = _isFilterByParentId;
    }

    getCommentRequest.isDeleted = _isDeleted ?? true ? null : false;

    if (dataTypeFilter != null) {
      getCommentRequest.dataTypes = dataTypeFilter!.dataTypes.map((e) => e.value).toList();
      getCommentRequest.matchType = dataTypeFilter!.matchType;
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

class AmityCommentDataTypeFilter {
  final List<AmityDataType> dataTypes;
  final String matchType;

  AmityCommentDataTypeFilter._internal(this.dataTypes, this.matchType);

  factory AmityCommentDataTypeFilter.any({required List<AmityDataType> dataTypes}) =>
      AmityCommentDataTypeFilter._internal(dataTypes, 'any');

  factory AmityCommentDataTypeFilter.exact({required List<AmityDataType> dataTypes}) =>
      AmityCommentDataTypeFilter._internal(dataTypes, 'exact');
}
