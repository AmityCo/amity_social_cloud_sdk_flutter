import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class MessageFlagUsecase extends UseCase<AmityMessage, String> {
  final MessageRepo messageRepo;

  MessageFlagUsecase({required this.messageRepo});

  @override
  Future<AmityMessage> get(String params) async {
    return messageRepo.flagMessage(params);
  }
}
