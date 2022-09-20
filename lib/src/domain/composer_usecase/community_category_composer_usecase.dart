import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class CommunityCategoryComposerUsecase
    extends UseCase<AmityCommunityCategory, AmityCommunityCategory> {
  final FileRepo fileRepo;

  CommunityCategoryComposerUsecase({required this.fileRepo});

  @override
  Future<AmityCommunityCategory> get(AmityCommunityCategory params) async {
    if (params.avatarId != null) {
      final fileProperties = await fileRepo.getFileByIdFromDb(params.avatarId!);
      params.avatar = AmityImage(fileProperties);
    }

    return params;
  }
}
