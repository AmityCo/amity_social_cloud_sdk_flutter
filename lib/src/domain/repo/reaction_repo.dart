import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

abstract class ReactionRepo {
  Future<PageListData<List<AmityReaction>, String>> getReaction(
      GetReactionRequest request);
  Future addReaction(ReactionRequest request);
  Future removeReaction(ReactionRequest request);
}
