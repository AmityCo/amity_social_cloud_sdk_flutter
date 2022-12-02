import 'dart:async';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// Message Observer Usecase
class MessageObserveUsecase
    extends UseCase<List<AmityMessage>, MessageQueryRequest> {
  /// Message Repo
  final MessageRepo messageRepo;

  /// Message Composer UseCase
  final MessageComposerUsecase messageComposerUsecase;

  /// Init [MessageObserveUsecase]
  MessageObserveUsecase(
      {required this.messageRepo, required this.messageComposerUsecase});

  @override
  Future<List<AmityMessage>> get(MessageQueryRequest params) async {
    throw UnimplementedError();
  }

  /// Listen Message Query Request
  StreamController<List<AmityMessage>> listen(
      RequestBuilder<MessageQueryRequest> request) {
    final streamController = StreamController<List<AmityMessage>>();

    messageRepo.listentMessages(request).listen((event) async {
      await Stream.fromIterable(event).forEach((element) async {
        element = await messageComposerUsecase.get(element);
      });
      streamController.add(event);
    });

    return streamController;
  }
}
