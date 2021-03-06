import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/domain/domain.dart';

class UserComposerUsecase extends UseCase<AmityUser, AmityUser> {
  final FileRepo fileRepo;

  UserComposerUsecase({required this.fileRepo});

  @override
  Future<AmityUser> get(AmityUser params) async {
    if (params.avatarFileId != null) {
      final _fileProperties =
          await fileRepo.getFileByIdFromDb(params.avatarFileId!);
      params.avatarCustomUrl = _fileProperties.fileUrl;
    }
    return params;
  }

  @override
  Stream<AmityUser> listen(AmityUser params) {
    // TODO: implement listen
    throw UnimplementedError();
  }
}
