import 'dart:ffi';

import 'package:amity_sdk/core/model/api_request/reaction_request.dart';

abstract class ReactionRepo {
  Future addReaction(ReactionRequest request);
  Future removeReaction(ReactionRequest request);
}
