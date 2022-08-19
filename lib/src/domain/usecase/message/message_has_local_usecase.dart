import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/repo/message_repo.dart';

class MessageHasLocalUsecase extends SynchronousUseCase<bool, String> {
  final MessageRepo messageRepo;
  // final MessageComposerUsecase messageComposerUsecase;
  MessageHasLocalUsecase({required this.messageRepo});

  @override
  bool get(String params) {
    return messageRepo.hasLocalMessage(params);
  }
}
