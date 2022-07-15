import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/model/amity_poll/amity_poll.dart';

/// Poll Response Extension
extension PollAnswerHiveEntityExtension on PollAnswerHiveEntity {
  /// Extension method to convert the response to hive entity
  AmityPollAnswer convertToAmityPollAnswer() {
    return AmityPollAnswer()
      ..id = id
      ..data = data
      ..dataType = dataType
      ..voteCount = voteCount
      ..isVotedByUser = isVotedByUser;
  }
}
