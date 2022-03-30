import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/domain/composer_usecase/user_compose_usecase.dart';
import 'package:amity_sdk/domain/domain.dart';

class CommunityComposerUsecase extends UseCase<AmityCommunity, AmityCommunity> {
  //TODO: Missing communityUserRepo tags and categoryRepo
  final CommunityRepo communityRepo;
  final UserRepo userRepo;
  final UserComposerUsecase userComposerUsecase;
  final FileRepo fileRepo;

  CommunityComposerUsecase(
      {required this.communityRepo,
      required this.userRepo,
      required this.userComposerUsecase,
      required this.fileRepo});

  @override
  Future<AmityCommunity> get(AmityCommunity params) async {
    //compose user
    if (params.userId != null) {
      params.user = await userRepo.getUserByIdFromDb(params.userId!);
      params.user = await userComposerUsecase.get(params.user!);
    }

    if (params.avatarFileId != null) {
      final _fileProperties =
          await fileRepo.getFileByIdFromDb(params.avatarFileId!);
      params.avatarImage = AmityImage(_fileProperties);
    }
    return params;
  }

  @override
  Stream<AmityCommunity> listen(AmityCommunity params) {
    // TODO: implement listen
    throw UnimplementedError();
  }
}
