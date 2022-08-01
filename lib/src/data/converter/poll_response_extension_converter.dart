import 'package:amity_sdk/src/data/data.dart';

/// Poll Response Extension
extension PollResponseExtension on PollResponse {
  /// Extension method to convert the response to hive entity
  PollHiveEntity convertToPollHiveEntity() {
    return PollHiveEntity()
      ..pollId = pollId
      ..userId = userId
      ..question = question
      ..answers = answers
          .map<PollAnswerHiveEntity>((e) => e.convertToPollAnswerHiveEntity())
          .toList()
      ..answerType = answerType
      ..closedAt = closedAt
      ..createdAt = createdAt
      ..updatedAt = updatedAt
      ..isVoted = isVoted
      ..status = status
      ..closeIn = closedIn
      ..isDeleted = isDeleted;
  }
}
