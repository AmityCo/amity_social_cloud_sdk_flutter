import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class CommunityDeleteUseCase extends UseCase<void, String> {
  final CommunityRepo communityRepo;

  CommunityDeleteUseCase({required this.communityRepo});
  @override
  Future get(String params) {
    return communityRepo.deleteCommunity(params);
  }

  @override
  Stream listen(String params) {
    // TODO: implement listen
    throw UnimplementedError();
  }
}
