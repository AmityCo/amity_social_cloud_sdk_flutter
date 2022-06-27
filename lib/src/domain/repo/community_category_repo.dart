import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

abstract class CommunityCategoryRepo {
  Future<PageListData<List<AmityCommunityCategory>, String>>
      getCommunityCategoryQuery(GetCommunityCategoryRequest request);
}
