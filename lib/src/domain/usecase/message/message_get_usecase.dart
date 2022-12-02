import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// [MessageGetUseCase]
class MessageGetUseCase extends UseCase<AmityMessage, String> {
  /// Message Repo
  final MessageRepo messageRepo;

  /// Message Composer Usecase
  final MessageComposerUsecase messageComposerUsecase;

  /// init [MessageGetUseCase]
  MessageGetUseCase(
      {required this.messageRepo, required this.messageComposerUsecase});

  @override
  Future<AmityMessage> get(String params) async {
    final amityMessage = await messageRepo.getMessage(params);
    final amityComposeMessage = await messageComposerUsecase.get(amityMessage);
    return amityComposeMessage;
  }
}
