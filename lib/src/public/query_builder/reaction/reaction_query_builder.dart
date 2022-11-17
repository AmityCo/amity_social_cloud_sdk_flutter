import 'package:amity_sdk/src/core/model/api_request/reaction_request.dart';
import 'package:amity_sdk/src/domain/usecase/reaction/add_reaction_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/reaction/remove_reaction_usecase.dart';

/// AddReactionQueryBuilder
class AddReactionQueryBuilder<T> {
  late AddReactionUsecase _addReactionUsecase;
  late RemoveReactionUsecase _removeReactionUsecase;
  late String _referenceType;
  late String _referenceId;

  /// init [AddReactionQueryBuilder]
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

  /// Add Reaction
  Future<T> addReaction(String reaction) {
    ReactionRequest reactionRequest = ReactionRequest(
        referenceId: _referenceId,
        referenceType: _referenceType,
        reactionName: reaction);
    return _addReactionUsecase.getWithType<T>(reactionRequest);
  }

  /// Remove Reaction
  Future<T> removeReaction(String reaction) {
    ReactionRequest reactionRequest = ReactionRequest(
        referenceId: _referenceId,
        referenceType: _referenceType,
        reactionName: reaction);
    return _removeReactionUsecase.getWithType<T>(reactionRequest);
  }
}
