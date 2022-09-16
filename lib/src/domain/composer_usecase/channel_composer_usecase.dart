import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// [ChannelComposerUsecase]
class ChannelComposerUsecase extends UseCase<AmityChannel, AmityChannel> {
  /// File Repo
  final FileRepo fileRepo;

  /// Init [ChannelComposerUsecase]
  ChannelComposerUsecase({required this.fileRepo});

  @override
  Future<AmityChannel> get(AmityChannel params) async {
    //Fill in the avatar fields
    if (params.avatarFileId != null) {
      final fileProperties =
          await fileRepo.getFileByIdFromDb(params.avatarFileId!);
      params.avatar = AmityImage(fileProperties);
    }

    return params;
  }

  @override
  Stream<AmityChannel> listen(AmityChannel params) {
    throw UnimplementedError();
  }
}
