import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/repo/reaction_repo.dart';

/// RemoveReactionUsecase
class RemoveReactionUsecase extends UseCase<void, ReactionRequest> {
  /// Reaction Repo
  final ReactionRepo reactionRepo;

  /// init [RemoveReactionUsecase]
  RemoveReactionUsecase({required this.reactionRepo});
  @override
  Future get(ReactionRequest params) {
    return reactionRepo.removeReaction(params);
  }

  @override
  Stream listen(ReactionRequest params) {
    throw UnimplementedError();
  }
}
