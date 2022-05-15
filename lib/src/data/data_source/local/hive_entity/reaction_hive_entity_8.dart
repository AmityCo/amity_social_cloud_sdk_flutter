// ignore_for_file: hash_and_equals

import 'package:hive/hive.dart';

part 'reaction_hive_entity_8.g.dart';

@HiveType(typeId: 8)
class ReactionHiveEntity extends HiveObject {
  String? reactionId;
  String? reactionName;
  String? userId;
  String? userDisplayName;
  String? referenceId;
  String? referenceType;
  DateTime? createdAt;

  @override
  int get hashCode => Object.hash(
      referenceType, referenceId, reactionName, userId, userDisplayName);
}
