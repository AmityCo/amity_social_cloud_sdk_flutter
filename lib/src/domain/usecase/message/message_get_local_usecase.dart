import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class MessageGetLocalUsecase extends SynchronousUseCase<AmityMessage?, String> {
  final MessageRepo messageRepo;
  // final MessageComposerUsecase messageComposerUsecase;
  MessageGetLocalUsecase({required this.messageRepo});

  @override
  AmityMessage? get(String params) {
    return messageRepo.getLocalMessage(params);
  }
}
