import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/domain/domain.dart';

class UserComposerUsecase extends UseCase<AmityUser, AmityUser> {
  final FileRepo fileRepo;

  UserComposerUsecase({required this.fileRepo});

  @override
  Future<AmityUser> get(AmityUser params) async {
    if (params.avatarFileId != null) {
      params.avatarCustomUrl =
          await fileRepo.getFileByIdFromDb(params.avatarFileId!);
    }
    return params;
  }

  @override
  Stream<AmityUser> listen(AmityUser params) {
    // TODO: implement listen
    throw UnimplementedError();
  }
}
