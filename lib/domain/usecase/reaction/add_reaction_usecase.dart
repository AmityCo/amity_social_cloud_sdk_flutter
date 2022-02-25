import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/core/model/api_request/reaction_request.dart';
import 'package:amity_sdk/domain/repo/reaction_repo.dart';

class AddReactionUsecase extends UseCase<void, ReactionRequest> {
  final ReactionRepo reactionRepo;

  AddReactionUsecase({required this.reactionRepo});

  @override
  Future get(ReactionRequest params) {
    return reactionRepo.addReaction(params);
  }

  @override
  Stream listen(ReactionRequest params) {
    // TODO: implement listen
    throw UnimplementedError();
  }
}
