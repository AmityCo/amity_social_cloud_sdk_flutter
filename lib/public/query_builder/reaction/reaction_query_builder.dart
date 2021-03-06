import 'package:amity_sdk/core/model/api_request/reaction_request.dart';
import 'package:amity_sdk/domain/usecase/reaction/add_reaction_usecase.dart';
import 'package:amity_sdk/domain/usecase/reaction/remove_reaction_usecase.dart';

class AddReactionQueryBuilder {
  late AddReactionUsecase _addReactionUsecase;
  late RemoveReactionUsecase _removeReactionUsecase;
  late String _referenceType;
  late String _referenceId;

  AddReactionQueryBuilder(
      {required AddReactionUsecase addReactionUsecase,
      required RemoveReactionUsecase removeReactionUsecase,
      required String referenceType,
      required String referenceId}) {
    _addReactionUsecase = addReactionUsecase;
    _removeReactionUsecase = removeReactionUsecase;
    _referenceType = referenceType;
    _referenceId = referenceId;
  }

  Future<void> addReaction(String reaction) {
    ReactionRequest reactionRequest = ReactionRequest(
        referenceId: _referenceId,
        referenceType: _referenceType,
        reactionName: reaction);
    return _addReactionUsecase.get(reactionRequest);
  }

  Future<void> removeReaction(String reaction) {
    ReactionRequest reactionRequest = ReactionRequest(
        referenceId: _referenceId,
        referenceType: _referenceType,
        reactionName: reaction);
    return _removeReactionUsecase.get(reactionRequest);
  }
}
