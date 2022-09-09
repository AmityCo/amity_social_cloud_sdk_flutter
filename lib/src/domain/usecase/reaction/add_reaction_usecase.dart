import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/repo/reaction_repo.dart';

/// AddReactionUsecase
class AddReactionUsecase extends UseCase<void, ReactionRequest> {
  /// Reaction Repo abs layer
  final ReactionRepo reactionRepo;

  /// init [AddReactionUsecase]
  AddReactionUsecase({required this.reactionRepo});

  @override
  Future get(ReactionRequest params) {
    return reactionRepo.addReaction(params);
  }

  @override
  Stream listen(ReactionRequest params) {
    throw UnimplementedError();
  }
}
