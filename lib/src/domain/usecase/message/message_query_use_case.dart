import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// [MessageQueryUseCase]
class MessageQueryUseCase extends UseCase<
    PageListData<List<AmityMessage>, String>, MessageQueryRequest> {
  /// Message Repo
  final MessageRepo messageRepo;

  /// Message Composer Usecase
  final MessageComposerUsecase messageComposerUsecase;

  /// init [MessageQueryUseCase]
  MessageQueryUseCase(
      {required this.messageRepo, required this.messageComposerUsecase});

  @override
  Future<PageListData<List<AmityMessage>, String>> get(
      MessageQueryRequest params) async {
    final amityMessage = await messageRepo.queryMesssage(params);
    final amityComposedMessage = await Stream.fromIterable(amityMessage.data)
        .asyncMap((event) => messageComposerUsecase.get(event))
        .toList();
    return amityMessage.withItem1(amityComposedMessage);
  }
}
