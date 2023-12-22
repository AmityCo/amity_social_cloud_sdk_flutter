// ignore_for_file: hash_and_equals

import 'package:amity_sdk/src/data/data_source/data_source.dart';
import 'package:hive/hive.dart';

part 'reaction_hive_entity_8.g.dart';

@HiveType(typeId: 8)
class ReactionHiveEntity extends EkoObject {
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
      
        @override
        String? getId() {
          return "$referenceType$referenceId$reactionName$userId";
        }
}
