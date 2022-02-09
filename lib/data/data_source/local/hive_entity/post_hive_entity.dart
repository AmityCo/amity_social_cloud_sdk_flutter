import 'package:hive/hive.dart';

part 'post_hive_entity.g.dart';

@HiveType(typeId: 0)
class PostHiveEntity extends HiveObject {
  @HiveField(0)
  String? id;

  // Hive fields go here
}
