import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/public/public.dart';

/// Poll Repository
class PollRepository {
  /// Create Poll
  PollCreateQueryBuilder createPoll({required String question}) {
    return PollCreateQueryBuilder(serviceLocator(), question);
  }

  /// Delete Poll
  Future<bool> deletePoll({required String pollId}) async {
    return serviceLocator<DeletePollUseCase>().get(pollId);
  }

  /// Vote for the poll id
  Future vote({required String pollId, required List<String> answerIds}) {
    return serviceLocator<PollVoteUseCase>()
        .get(PollVoteRequest(pollId: pollId, answerIds: answerIds));
  }
}
