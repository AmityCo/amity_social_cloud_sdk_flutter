import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// Poll Response Extension
extension PollHiveEntityExtension on PollHiveEntity {
  /// Extension method to convert the response to hive entity
  AmityPoll convertToAmityPoll() {
    return AmityPoll()
      ..pollId = pollId
      ..userId = userId
      ..question = question
      ..answers = answers!
          .map<AmityPollAnswer>((e) => e.convertToAmityPollAnswer())
          .toList()
      ..answerType = AmityPollAnswerTypeExtension.enumOf(answerType!)
      ..closedAt = closedAt
      ..createdAt = createdAt
      ..updatedAt = updatedAt
      ..isVoted = isVoted
      ..status = AmityPollStatusExtension.enumOf(status!)
      ..closedIn = closeIn;
  }
}
