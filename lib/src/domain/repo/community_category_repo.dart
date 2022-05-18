import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/model/api_request/get_community_category_request.dart';
import 'package:amity_sdk/src/domain/domain.dart';

abstract class CommunityCategoryRepo {
  Future<Tuple2<List<AmityCommunityCategory>, String>> communityCategoryQuery(
      GetCommunityCategoryRequest request);
}
