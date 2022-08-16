import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/model/api_request/create_message_request.dart';
import 'package:amity_sdk/src/domain/composer_usecase/message_composer_usecase.dart';
import 'package:amity_sdk/src/domain/model/message/amity_message.dart';
import 'package:amity_sdk/src/domain/repo/message_repo.dart';

/// [MessageCreateUsecase]
class MessageCreateUsecase extends UseCase<AmityMessage, CreateMessageRequest> {
  /// Message Repo
  final MessageRepo messageRepo;

  /// Message Composer Usecase
  final MessageComposerUsecase messageComposerUsecase;

  /// Init [MessageCreateUsecase]
  MessageCreateUsecase(
      {required this.messageRepo, required this.messageComposerUsecase});

  @override
  Future<AmityMessage> get(CreateMessageRequest params) async {
    final amityMessage = await messageRepo.createMessage(params);
    final amityComposeMessage = await messageComposerUsecase.get(amityMessage);
    return amityComposeMessage;
  }

  @override
  Stream<AmityMessage> listen(CreateMessageRequest params) {
    throw UnimplementedError();
  }
}
