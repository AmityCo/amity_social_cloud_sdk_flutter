import 'dart:async';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/public/public.dart';

/// Amity Message Extension
extension AmityMessageExtension on AmityMessage {
  /// React On Amity Mesage
  AddReactionQueryBuilder react() {
    return AddReactionQueryBuilder<AmityMessage>(
        addReactionUsecase: serviceLocator(),
        removeReactionUsecase: serviceLocator(),
        referenceType: AmityReactionReferenceType.MESSAGE.value,
        referenceId: messageId!);
  }

  /// Get Amity Mesage Reaction
  GetReactionQueryBuilder getReaction() {
    return GetReactionQueryBuilder.message(messageId: messageId!);
  }

  /// Get Amity Mesage Reaction
  AmityMessageUpdateQueryBuilder upate() {
    return AmityMessageUpdateQueryBuilder(
        useCase: serviceLocator<MessageUpdateUsecase>(),
        channelId: channelId!,
        messageId: messageId!);
  }

  Future delete() {
    return serviceLocator<MessageDeleteUsecase>().get(messageId!);
  }

  /// Listen Mesage Id
  StreamController<AmityMessage> get listen {
    StreamController<AmityMessage> controller =
        StreamController<AmityMessage>();

    serviceLocator<MessageDbAdapter>()
        .listenMessageEntity(messageId!)
        .listen((event) {
      final updateAmityMessage = event.convertToAmityMessage();

      //TOOD: Good idea would be have compose method inside the object itself
      serviceLocator<MessageComposerUsecase>().get(updateAmityMessage).then(
            (value) => controller.add(value),
          );
    });

    return controller;
  }
}
