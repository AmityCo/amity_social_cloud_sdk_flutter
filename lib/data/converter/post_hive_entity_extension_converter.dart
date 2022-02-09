import 'package:amity_sdk/data/data_source/local/hive_entity/post_hive_entity.dart';
import 'package:amity_sdk/domain/model/amity_post.dart';

extension PostHiveEntityExtension on PostHiveEntity {
  AmityPost convertoAmityPost() {
    return AmityPost()..id = id;
  }
}
