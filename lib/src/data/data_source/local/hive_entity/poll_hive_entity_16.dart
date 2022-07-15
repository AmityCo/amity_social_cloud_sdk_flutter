import 'package:amity_sdk/src/core/enum/enum.dart';
import 'package:amity_sdk/src/data/data_source/local/hive_entity/poll_answer_hive_entity_17.dart';
import 'package:hive/hive.dart';

part 'poll_hive_entity_16.g.dart';

/// Poll post Hive Entity
@HiveType(typeId: 16)
class PollHiveEntity {
  /// Poll Id
  String? pollId;

  /// User Id who created the poll
  String? userId;

  /// Question in the poll post
  String? question;

  /// List of Answer in the poll post
  List<PollAnswerHiveEntity>? answers;

  /// Answer type in the poll post
  String? answerType = AmityPollAnswerType.UNKNOWN.value;

  /// Poll post status
  String? status = AmityPollStatus.UNKNOWN.value;

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

  /// Poll close In
  int? closeIn;
}
