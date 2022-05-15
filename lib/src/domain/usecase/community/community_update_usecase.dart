import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class CommunityUpdateUseCase
    extends UseCase<AmityCommunity, CreateCommunityRequest> {
  final CommunityRepo communityRepo;
  final CommunityComposerUsecase communityComposerUsecase;

  CommunityUpdateUseCase(
      {required this.communityRepo, required this.communityComposerUsecase});
  @override
  Future<AmityCommunity> get(CreateCommunityRequest params) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Stream<AmityCommunity> listen(CreateCommunityRequest params) {
    // TODO: implement listen
    throw UnimplementedError();
  }
}
