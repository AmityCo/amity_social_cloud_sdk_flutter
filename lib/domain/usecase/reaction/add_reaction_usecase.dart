import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/core/model/api_request/reaction_request.dart';
import 'package:amity_sdk/domain/repo/reaction_repo.dart';

class AddReactionUsecase extends UseCase<String, ReactionRequest> {
  final ReactionRepo reactionRepo;

  AddReactionUsecase({required this.reactionRepo});

  @override
  Future<String> get(ReactionRequest params) {
    return reactionRepo.addReaction(params);
  }

  @override
  Stream<String> listen(ReactionRequest params) {
    // TODO: implement listen
    throw UnimplementedError();
  }
}
