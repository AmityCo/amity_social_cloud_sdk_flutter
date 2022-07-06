import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class GetReactionQueryBuilder {
  GetReactionUsecase _usecase;
  AmityReactionReferenceType _referenceType;
  String _referenceId;
  String? _reactionName;

  GetReactionQueryBuilder(
      this._usecase, this._referenceType, this._referenceId);

  factory GetReactionQueryBuilder.post({required String postId}) {
    return GetReactionQueryBuilder(
      serviceLocator<GetReactionUsecase>(),
      AmityReactionReferenceType.POST,
      postId,
    );
  }

  factory GetReactionQueryBuilder.comment({required String commentId}) {
    return GetReactionQueryBuilder(
      serviceLocator<GetReactionUsecase>(),
      AmityReactionReferenceType.COMMENT,
      commentId,
    );
  }

  factory GetReactionQueryBuilder.message(String messageId) {
    return GetReactionQueryBuilder(
      serviceLocator<GetReactionUsecase>(),
      AmityReactionReferenceType.MESSAGE,
      messageId,
    );
  }

  GetReactionQueryBuilder reactionName(String reactionName) {
    _reactionName = reactionName;
    return this;
  }

  Future<PageListData<List<AmityReaction>, String>> getPagingData(
      {String? token, int? limit}) async {
    final request = GetReactionRequest(
        referenceId: _referenceId, referenceType: _referenceType.value);
    if (_reactionName != null) request.reactionName = _reactionName;

    request.options = OptionsRequest();

    if (token != null) {
      request.options!.token = token;
    }
    if (limit != null) {
      request.options!.limit = limit;
    }

    final data = await _usecase.get(request);

    return data;
  }
}
