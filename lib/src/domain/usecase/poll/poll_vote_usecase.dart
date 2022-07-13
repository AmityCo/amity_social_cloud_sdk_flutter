import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/domain/repo/poll_repo.dart';

/// Get Poll Use Case
class PollVoteUseCase extends UseCase<AmityPoll, PollVoteRequest> {
  /// Poll Repo
  final PollRepo pollRepo;

  /// Init Get Post Usecase
  PollVoteUseCase({required this.pollRepo});
  @override
  Future<AmityPoll> get(PollVoteRequest params) {
    return pollRepo.votePoll(params);
  }

  @override
  Stream<AmityPoll> listen(PollVoteRequest params) {
    throw UnimplementedError();
  }
}
