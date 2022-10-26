import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// [MessageCreateFileUsecase]
class MessageCreateFileUsecase
    extends UseCase<AmityMessage, CreateMessageRequest> {
  /// Message Repo
  final MessageRepo messageRepo;

  /// Message Composer Usecase
  final MessageComposerUsecase messageComposerUsecase;

  /// Init [MessageCreateFileUsecase]
  MessageCreateFileUsecase(
      {required this.messageRepo, required this.messageComposerUsecase});

  @override
  Future<AmityMessage> get(CreateMessageRequest params) async {
    final amityMessage = await messageRepo.createFileMessage(params);
    final amityComposeMessage = await messageComposerUsecase.get(amityMessage);
    return amityComposeMessage;
  }
}
