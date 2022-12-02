import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// [MessageDeleteUsecase]
class MessageDeleteUsecase extends UseCase<void, String> {
  /// Message Repo
  final MessageRepo messageRepo;

  /// Init [MessageDeleteUsecase]
  MessageDeleteUsecase({required this.messageRepo});

  @override
  Future<void> get(String params) async {
    return messageRepo.deleteMessage(params);
  }
}
