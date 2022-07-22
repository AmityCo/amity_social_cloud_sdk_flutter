import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';

/// Abs layer for Poll Api Interface
abstract class PollApiInterface {
  /// Create Poll
  Future<CreatePostResponse> createPoll(CreatePollRequest request);

  /// Vote for the poll
  Future<CreatePostResponse> votePoll(PollVoteRequest request);

  /// Vote for the poll
  Future<CreatePostResponse> closePoll(PollVoteRequest request);

  /// Delete Vote for the poll
  Future<bool> deleteVotePoll(PollVoteRequest request);
}
