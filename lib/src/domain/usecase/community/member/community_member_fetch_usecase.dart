import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class CommunityMemberFetchListUseCase extends UseCase<
    PageListData<List<AmityCommunityMember>, String>,
    GetCommunityMembersRequest> {
  final CommunityMemberRepo repo;

  CommunityMemberFetchListUseCase({required this.repo});

  @override
  Future<PageListData<List<AmityCommunityMember>, String>> get(
      GetCommunityMembersRequest params) async {
    return await repo.queryCommunityMembers(params);
  }
}
