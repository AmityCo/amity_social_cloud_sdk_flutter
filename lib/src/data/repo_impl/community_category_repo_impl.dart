import 'package:amity_sdk/src/core/utils/tuple.dart';
import 'package:amity_sdk/src/data/data_source/remote/api_interface/community_category_api_interface.dart';
import 'package:amity_sdk/src/domain/model/amity_community_category.dart';
import 'package:amity_sdk/src/domain/repo/community_category_repo.dart';

import '../../core/model/api_request/get_community_category_request.dart';

class CommunityCategoryRepoImpl extends CommunityCategoryRepo {
  final CommunityCategoryApiInterface communityCategoryApiInterface;

  CommunityCategoryRepoImpl({required this.communityCategoryApiInterface});
  @override
  Future<Tuple2<List<AmityCommunityCategory>, String>> communityCategoryQuery(
      GetCommunityCategoryRequest request) async {
    final data =
        await communityCategoryApiInterface.communityCategoryQuery(request);
    return Tuple2(data.categories, data.paging?.next ?? '');
  }
}
