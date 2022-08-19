import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/model/message/amity_message.dart';

import 'package:amity_sdk/src/domain/repo/message_repo.dart';

class MessageObserveUsecase
    extends UseCase<List<AmityMessage>, MessageQueryRequest> {
  final MessageRepo messageRepo;
  // final MessageComposerUsecase messageComposerUsecase;
  MessageObserveUsecase({required this.messageRepo});

  @override
  Future<List<AmityMessage>> get(MessageQueryRequest params) async {
    throw UnimplementedError();
  }

  @override
  Stream<List<AmityMessage>> listen(MessageQueryRequest params) {
    //missing compose use case :(
    return messageRepo.listentMessages(params);
  }
}
