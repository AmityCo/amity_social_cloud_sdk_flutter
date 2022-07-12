import 'package:amity_sdk/src/core/enum/enum.dart';

/// Amity Poll Answer
class AmityPollAnswer {
  /// Answer Id
  String? id;

  /// Answer Option
  String? data;

  /// Answer Data type
  String? dataType = AmityPollAnswerDataType.TEXT.value;

  /// Answer Vote count
  int? voteCount;

  /// Flag to check if user have voted for this answer
  bool? isVotedByUser = false;

  @override
  String toString() {
    return 'AmityPollAnswer(id: $id, data: $data, dataType: $dataType, voteCount: $voteCount, isVotedByUser: $isVotedByUser)';
  }
}
