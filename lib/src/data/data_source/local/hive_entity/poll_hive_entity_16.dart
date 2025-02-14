import 'package:amity_sdk/src/core/enum/enum.dart';
import 'package:amity_sdk/src/core/utils/amity_hive_type.dart';
import 'package:amity_sdk/src/data/data_source/data_source.dart';
import 'package:hive/hive.dart';

part 'poll_hive_entity_16.g.dart';

/// Poll post Hive Entity
@HiveType(typeId: AmityHiveType.poll)
class PollHiveEntity extends EkoObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? pollId;

  @HiveField(2)
  String? userId;

  @HiveField(3)
  String? question;

  @HiveField(4)
  List<PollAnswerHiveEntity>? answers;

  @HiveField(5)
  String? answerType = AmityPollAnswerType.UNKNOWN.value;

  @HiveField(6)
  String? status = AmityPollStatus.UNKNOWN.value;

  @HiveField(7)
  DateTime? closedAt;

  @HiveField(8)
  bool? isDeleted = false;

  @HiveField(9)
  bool? isVoted = false;

  @HiveField(10)
  DateTime? createdAt;

  @HiveField(11)
  DateTime? updatedAt;

  @HiveField(12)
  int? closeIn;

  PollHiveEntity({
    this.id,
    this.pollId,
    this.userId,
    this.question,
    this.answers,
    this.answerType,
    this.status,
    this.closedAt,
    this.isDeleted,
    this.isVoted,
    this.createdAt,
    this.updatedAt,
    this.closeIn,
  });

  PollHiveEntity copyWith({
    String? id,
    String? pollId,
    String? userId,
    String? question,
    List<PollAnswerHiveEntity>? answers,
    String? answerType,
    String? status,
    DateTime? closedAt,
    bool? isDeleted,
    bool? isVoted,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? closeIn,
  }) {
    return PollHiveEntity(
      id: id ?? this.id,
      pollId: pollId ?? this.pollId,
      userId: userId ?? this.userId,
      question: question ?? this.question,
      answers: answers ?? this.answers,
      answerType: answerType ?? this.answerType,
      status: status ?? this.status,
      closedAt: closedAt ?? this.closedAt,
      isDeleted: isDeleted ?? this.isDeleted,
      isVoted: isVoted ?? this.isVoted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      closeIn: closeIn ?? this.closeIn,
    );
  }

  @override
  String? getId() {
    return id;
  }
}
