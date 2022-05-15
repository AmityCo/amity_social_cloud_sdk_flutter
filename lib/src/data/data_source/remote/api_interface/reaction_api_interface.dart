import 'package:amity_sdk/src/core/model/api_request/reaction_request.dart';

abstract class ReactionApiInterface {
  Future<String> addReaction(ReactionRequest request);
  Future<String> removeReaction(ReactionRequest request);
}
