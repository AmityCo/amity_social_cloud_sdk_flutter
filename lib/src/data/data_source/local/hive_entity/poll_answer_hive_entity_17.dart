import 'package:amity_sdk/src/core/enum/enum.dart';
import 'package:amity_sdk/src/core/utils/amity_hive_type.dart';
import 'package:hive/hive.dart';

part 'poll_answer_hive_entity_17.g.dart';

/// Poll post Answers Hive Entity
@HiveType(typeId: AmityHiveType.pollAnswer)
class PollAnswerHiveEntity {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? data;

  @HiveField(2)
  String? dataType = AmityPollAnswerDataType.TEXT.value;

  @HiveField(3)
  int? voteCount;

  @HiveField(4)
  bool? isVotedByUser = false;

  PollAnswerHiveEntity({
    this.id,
    this.data,
    this.dataType,
    this.voteCount,
    this.isVotedByUser,
  });

  PollAnswerHiveEntity copyWith({
    String? id,
    String? data,
    String? dataType,
    int? voteCount,
    bool? isVotedByUser,
  }) {
    return PollAnswerHiveEntity(
      id: id ?? this.id,
      data: data ?? this.data,
      dataType: dataType ?? this.dataType,
      voteCount: voteCount ?? this.voteCount,
      isVotedByUser: isVotedByUser ?? this.isVotedByUser,
    );
  }
}
