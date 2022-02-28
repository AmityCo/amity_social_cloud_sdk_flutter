import 'dart:ffi';

import 'package:amity_sdk/core/model/api_request/reaction_request.dart';
import 'package:amity_sdk/data/data_source/remote/api_interface/reaction_api_interface.dart';
import 'package:amity_sdk/domain/repo/reaction_repo.dart';

class ReactionRepoImpl extends ReactionRepo {
  final ReactionApiInterface reactionApiInterface;

  ReactionRepoImpl({required this.reactionApiInterface});

  @override
  Future addReaction(ReactionRequest request) async {
    await reactionApiInterface.addReaction(request);
  }

  @override
  Future removeReaction(ReactionRequest request) async {
    await reactionApiInterface.removeReaction(request);
  }
}
