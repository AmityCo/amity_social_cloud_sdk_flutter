import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class CommunityMemberComposerUsecase
    extends UseCase<AmityCommunityMember, AmityCommunityMember> {
  final UserRepo userRepo;
  final UserComposerUsecase userComposerUsecase;

  CommunityMemberComposerUsecase(
      {required this.userRepo, required this.userComposerUsecase});

  @override
  Future<AmityCommunityMember> get(AmityCommunityMember params) async {
    final rawUser = await userRepo.getUserByIdFromDb(params.userId!);
    params.user = await userComposerUsecase.get(rawUser);
    return params;
  }

  @override
  Stream<AmityCommunityMember> listen(AmityCommunityMember params) {
    // TODO: implement listen
    throw UnimplementedError();
  }
}
