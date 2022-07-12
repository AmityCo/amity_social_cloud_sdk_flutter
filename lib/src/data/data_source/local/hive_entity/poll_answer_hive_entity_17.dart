import 'package:amity_sdk/src/core/enum/enum.dart';
import 'package:hive/hive.dart';

part 'poll_answer_hive_entity_17.g.dart';

/// Poll post Answers Hive Entity
@HiveType(typeId: 17)
class PollAnswerHiveEntity {
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
}
