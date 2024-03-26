import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/model/api_request/get_post_count_request.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class CommunityPostCountUseCase extends UseCase<int , GetPostCountRequest> {

  final CommunityRepo communityRepo;

  CommunityPostCountUseCase({required this.communityRepo});

  @override
  Future<int> get(GetPostCountRequest params) async {
    return communityRepo.getPostCount(params.targetId, params.feedType);
  }
  
}