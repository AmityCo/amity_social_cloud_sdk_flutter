import 'package:amity_sdk/src/core/enum/enum.dart';
import 'package:amity_sdk/src/domain/model/amity_poll/amity_poll.dart';

/// Poll Post  Entity
class AmityPoll {
  /// Poll Id
  String? pollId;

  /// User Id who created the poll
  String? userId;

  /// Question in the poll post
  String? question;

  /// List of Answer in the poll post
  List<AmityPollAnswer>? answers;

  /// Answer type in the poll post
  AmityPollAnswerType? answerType = AmityPollAnswerType.UNKNOWN;

  /// Poll post status
  AmityPollStatus? status = AmityPollStatus.UNKNOWN;

  /// Close time for the poll post
  DateTime? closedAt;

  /// local flag for deleting the post
  bool? isDeleted = false;

  /// Flag to check if user have alrady voted the poll
  bool? isVoted = false;

  /// Created Time for the poll post
  DateTime? createdAt;

  /// Updated Time for the poll post
  DateTime? updatedAt;

  /// Poll Close In
  int? closedIn;

  /// flag if poll is closed
  bool get isClose =>
      status == AmityPollStatus.CLOSED || DateTime.now().isAfter(closedAt!);

  /// get the total vote count
  int get totalVote => answers!.fold(
      0, (previousValue, element) => previousValue + (element.voteCount ?? 0));

  @override
  String toString() {
    return 'AmityPoll(pollId: $pollId, userId: $userId, question: $question, answers: $answers, closedAt: $closedAt, isDeleted: $isDeleted, isVoted: $isVoted, createdAt: $createdAt, updatedAt: $updatedAt, closedIn: $closedIn, isClose: $isClose)';
  }
}
