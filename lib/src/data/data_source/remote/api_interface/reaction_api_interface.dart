import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';

abstract class ReactionApiInterface {
  Future<GetReactionResponse> getReaction(GetReactionRequest request);
  Future<String> addReaction(ReactionRequest request);
  Future<String> removeReaction(ReactionRequest request);
}
