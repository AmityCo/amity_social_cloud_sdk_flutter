import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class CommunityDeleteUseCase extends UseCase<AmityCommunity, String> {
  final CommunityRepo communityRepo;

  CommunityDeleteUseCase({required this.communityRepo});
  @override
  Future<AmityCommunity> get(String params) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Stream<AmityCommunity> listen(String params) {
    // TODO: implement listen
    throw UnimplementedError();
  }
}
