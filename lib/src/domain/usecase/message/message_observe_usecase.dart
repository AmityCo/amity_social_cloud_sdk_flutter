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

  @override
  Stream<List<AmityMessage>> listen(MessageQueryRequest params) {
    //missing compose use case :(
    final streamController = StreamController<List<AmityMessage>>();

    messageRepo.listentMessages(params).listen((event) async {
      await Stream.fromIterable(event).forEach((element) async {
        element = await messageComposerUsecase.get(element);
      });
      streamController.add(event);
    });

    return streamController.stream;
  }
}
