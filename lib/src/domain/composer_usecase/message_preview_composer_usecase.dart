import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/domain/model/message/amity_message_preview.dart';

class MessagePreviewComposerUsecase
    extends UseCase<AmityMessagePreview, AmityMessagePreview> {

  final UserRepo userRepo;
  final UserComposerUsecase userComposerUsecase;

  MessagePreviewComposerUsecase(
      {required this.userRepo, required this.userComposerUsecase});

  @override
  Future<AmityMessagePreview> get(AmityMessagePreview params) async {
    final user = await userRepo.getUserByIdFromDb(params.userId);
    params.user = await userComposerUsecase.get(user);

    return params;
  }
}
