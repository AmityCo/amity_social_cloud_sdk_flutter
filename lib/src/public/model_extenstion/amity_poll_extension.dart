import 'dart:async';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// Amity Poll Extension method
extension AmityPollExtension on AmityPoll {
  /// Delete poll
  Future<bool> delete() {
    return serviceLocator<DeletePollUseCase>().get(pollId!);
  }

  /// Lister Poll Model with PollId
  StreamController<AmityPoll> get listen {
    final controller = StreamController<AmityPoll>();

    serviceLocator<PollDbAdapter>().listenPollEntity(pollId!).listen((event) {
      final updateAmityPoll = event.convertToAmityPoll();
      controller.add(updateAmityPoll);
    });

    return controller;
  }

  /// Close the current Poll
  Future<AmityPoll> close() {
    return serviceLocator<ClosePollUseCase>()
        .get(PollVoteRequest(pollId: pollId!));
  }
}
