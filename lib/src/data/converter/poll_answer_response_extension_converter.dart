import 'package:amity_sdk/src/data/data.dart';

/// Poll Response Extension
extension PollAnsterResponseExtension on PollAnswer {
  /// Extension method to convert the response to hive entity
  PollAnswerHiveEntity convertToPollAnswerHiveEntity() {
    return PollAnswerHiveEntity()
      ..id = id
      ..dataType = dataType
      ..data = data
      ..voteCount = voteCount
      ..isVotedByUser = isVotedByUser;
  }
}