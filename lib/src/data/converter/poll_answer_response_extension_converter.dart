import 'package:amity_sdk/src/data/data.dart';

/// Poll Response Extension
extension PollAnsterResponseExtension on PollAnswer {
  /// Extension method to convert the response to hive entity
  PollAnswerHiveEntity convertToPollAnswerHiveEntity() {
    return PollAnswerHiveEntity()
      ..dataType = dataType
      ..data = data
      ..voteCount = voteCount
      ..isVotedByUser = isVotedByUser
      ..id = id;
  }
}
