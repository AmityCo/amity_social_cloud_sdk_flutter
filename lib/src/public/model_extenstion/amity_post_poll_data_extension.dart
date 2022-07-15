import 'package:amity_sdk/src/core/service_locator/service_locator.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// Amity Post Poll Data Extension
extension AmityPostPollDataExtension on PollData {
  /// Get the poll post detail
  Future<AmityPoll> getPoll() async {
    return serviceLocator<GetPollUseCase>().get(pollId);
  }
}
