import 'package:amity_sdk/src/data/data_source/local/hive_entity/community_category_hive_12.dart';

abstract class CommunityCategoryDbAdapter {
  Future saveCommunityCategoryEntity(CommunityCategoryHiveEntity entity);
  CommunityCategoryHiveEntity? getCommunityCategoryEntity(String id);
}
