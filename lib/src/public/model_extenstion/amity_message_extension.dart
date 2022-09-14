import 'dart:async';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/public/public.dart';

/// Amity Message Extension
extension AmityMessageExtension on AmityMessage {
  /// React On Amity Post
  AddReactionQueryBuilder react() {
    return AddReactionQueryBuilder(
        addReactionUsecase: serviceLocator(),
        removeReactionUsecase: serviceLocator(),
        referenceType: AmityReactionReferenceType.MESSAGE.value,
        referenceId: messageId!);
  }

  /// Get Amity Post Reaction
  GetReactionQueryBuilder getReaction() {
    return GetReactionQueryBuilder.message(messageId: messageId!);
  }

  /// Amity Post Report
  // PostFlagQueryBuilder report() {
  //   return PostFlagQueryBuilder(
  //       postFlagUsecase: serviceLocator(),
  //       postUnflagUsecase: serviceLocator(),
  //       postId: postId!);
  // }

  /// Listen Post Id
  Stream<AmityMessage> get listen {
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

    return controller.stream;
  }

  /// check if post is flagged by me
  // bool get isFlaggedByMe {
  //   if (hashFlag == null) return false;
  //   return (flaggedByMe ?? false) ||
  //       BloomFilter(
  //               hash: (hashFlag!['hash'] as String),
  //               m: hashFlag!['bits'] as int,
  //               k: hashFlag!['hashes'] as int)
  //           .mightContains(AmityCoreClient.getUserId());
  // }
}
