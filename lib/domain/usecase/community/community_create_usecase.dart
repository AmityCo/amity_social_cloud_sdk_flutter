import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/domain/domain.dart';

import '../../../core/model/api_request/create_community_request.dart';
import '../../composer_usecase/community_composer_usecase.dart';

class CommunityCreateUsecase
    extends UseCase<AmityCommunity, CreateCommunityRequest> {
  final CommunityRepo communityRepo;
  final CommunityComposerUsecase communityComposerUsecase;

  CommunityCreateUsecase(
      {required this.communityRepo, required this.communityComposerUsecase});

  @override
  Future<AmityCommunity> get(CreateCommunityRequest params) async {
    final amityCommunity = await communityRepo.createCommunity(params);
    final amityCreatedCommunity =
        await communityComposerUsecase.get(amityCommunity);
    return amityCreatedCommunity;
  }

  @override
  Stream<AmityCommunity> listen(CreateCommunityRequest params) {
    // TODO: implement listen
    throw UnimplementedError();
  }
}
