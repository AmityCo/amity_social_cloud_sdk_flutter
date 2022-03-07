import 'package:amity_sdk/core/model/api_request/reaction_request.dart';
import 'package:amity_sdk/domain/usecase/reaction/Remove_reaction_usecase.dart';

class RemoveReactionQueryBuilder {
  late RemoveReactionUsecase _useCase;
  late String _referenceType;
  late String _referenceId;

  RemoveReactionQueryBuilder(
      {required RemoveReactionUsecase useCase,
      required String referenceType,
      required String referenceId}) {
    _useCase = useCase;
    referenceType = _referenceType;
    referenceId = _referenceId;
  }

  Future<String> removeReaction(String reaction) {
    ReactionRequest reactionRequest = ReactionRequest(
        referenceId: _referenceId,
        referenceType: _referenceType,
        reactionName: reaction);
    return _useCase.get(reactionRequest);
  }
}
