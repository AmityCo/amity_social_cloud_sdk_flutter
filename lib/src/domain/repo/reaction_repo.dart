import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// ReactionRepo Abstract Layer
abstract class ReactionRepo {
  /// Get Reaction
  Future<PageListData<List<AmityReaction>, String>> getReaction(
      GetReactionRequest request);

  /// Add Reaction
  Future<T> addReaction<T>(ReactionRequest request);

  /// Remove Reaction
  Future<T> removeReaction<T>(ReactionRequest request);
}
