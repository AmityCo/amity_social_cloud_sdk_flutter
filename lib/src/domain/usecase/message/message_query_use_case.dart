import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/model/message/amity_message.dart';
import 'package:amity_sdk/src/domain/repo/message_repo.dart';

/// [MessageQueryUseCase]
class MessageQueryUseCase extends UseCase<
    PageListData<List<AmityMessage>, String>, MessageQueryRequest> {
  /// Message Repo
  final MessageRepo messageRepo;
  // final PostComposerUsecase postComposerUsecase;

  /// init [MessageQueryUseCase]
  MessageQueryUseCase({required this.messageRepo});

  @override
  Future<PageListData<List<AmityMessage>, String>> get(
      MessageQueryRequest params) async {
    final amityMessage = await messageRepo.queryMesssage(params);
    // final amityComposedPost = await Stream.fromIterable(amityPost.data)
    //     .asyncMap((event) => postComposerUsecase.get(event))
    //     .toList();
    return amityMessage;
  }
}
