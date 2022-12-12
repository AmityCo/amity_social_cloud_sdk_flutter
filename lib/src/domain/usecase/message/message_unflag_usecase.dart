import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class MessageUnflagUsecase extends UseCase<AmityMessage, String> {
  final MessageRepo messageRepo;

  MessageUnflagUsecase({required this.messageRepo});

  @override
  Future<AmityMessage> get(String params) async {
    return messageRepo.unFlagMessage(params);
  }
}
