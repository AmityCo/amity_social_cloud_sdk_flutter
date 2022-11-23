import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/model/message/amity_message.dart';
import 'package:amity_sdk/src/domain/repo/message_repo.dart';

/// [MessageGetUseCase]
class MessageGetUseCase extends UseCase<AmityMessage, String> {
  /// Message Repo
  final MessageRepo messageRepo;
  // final PostComposerUsecase postComposerUsecase;

  /// init [MessageGetUseCase]
  MessageGetUseCase({required this.messageRepo});

  @override
  Future<AmityMessage> get(String params) async {
    final amityMessage = await messageRepo.getMessage(params);
    // final amityComposedPost = await Stream.fromIterable(amityPost.data)
    //     .asyncMap((event) => postComposerUsecase.get(event))
    //     .toList();
    return amityMessage;
  }
}
