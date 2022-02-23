import 'package:amity_sdk/core/model/api_request/reaction_request.dart';

abstract class ReactionRepo {
  Future<String> addReaction(ReactionRequest request);
  Future<String> removeReaction(ReactionRequest request);
}
