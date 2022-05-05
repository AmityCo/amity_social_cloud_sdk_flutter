import 'package:amity_sdk/src/core/model/api_request/reaction_request.dart';

abstract class ReactionRepo {
  Future addReaction(ReactionRequest request);
  Future removeReaction(ReactionRequest request);
}
