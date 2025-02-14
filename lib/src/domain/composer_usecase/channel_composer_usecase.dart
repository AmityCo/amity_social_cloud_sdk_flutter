import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/converter/message_preview/message_preview_hive_extention_converter.dart';
import 'package:amity_sdk/src/domain/composer_usecase/message_preview_composer_usecase.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/domain/repo/message_preview_repo.dart';

/// [ChannelComposerUsecase]
class ChannelComposerUsecase extends UseCase<AmityChannel, AmityChannel> {
  /// File Repo
  final FileRepo fileRepo;
  final MessagePreviewRepo messagePreviewRepo;
  final MessagePreviewComposerUsecase messagePreviewComposerUsecase;

  /// Init [ChannelComposerUsecase]
  ChannelComposerUsecase(
      {required this.fileRepo,
      required this.messagePreviewRepo,
      required this.messagePreviewComposerUsecase});

  @override
  Future<AmityChannel> get(AmityChannel params) async {
    //Fill in the avatar fields
    if (params.avatarFileId != null) {
      final fileProperties =
          await fileRepo.getFileByIdFromDb(params.avatarFileId!);
      params.avatar = AmityImage(fileProperties);
    }

    final channelId = params.channelId;
    if (channelId != null) {
      final messagePreviewEntity =
          await messagePreviewRepo.getMessagePreviewByChannelId(channelId);
       final messagePreview = messagePreviewEntity?.convertToAmityMessagePreview();
       if (messagePreview != null) {
         params.messagePreview = await messagePreviewComposerUsecase.get(messagePreview);
       }
    }

    return params;
  }
}
