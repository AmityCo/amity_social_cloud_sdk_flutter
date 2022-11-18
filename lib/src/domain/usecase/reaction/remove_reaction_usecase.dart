import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/repo/reaction_repo.dart';

/// RemoveReactionUsecase
class RemoveReactionUsecase extends UseCase<dynamic, ReactionRequest> {
  /// Reaction Repo
  final ReactionRepo reactionRepo;

  /// init [RemoveReactionUsecase]
  RemoveReactionUsecase({required this.reactionRepo});
  @override
  Future<dynamic> get(ReactionRequest params) {
    return reactionRepo.removeReaction(params);
  }

  Future<T> getWithType<T>(ReactionRequest params) {
    return reactionRepo.removeReaction<T>(params);
  }
}
