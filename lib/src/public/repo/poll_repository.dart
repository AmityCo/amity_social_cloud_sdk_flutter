import 'package:amity_sdk/src/core/service_locator/service_locator.dart';
import 'package:amity_sdk/src/public/public.dart';

/// Poll Repository
class PollRepository {
  /// Create Poll
  PollCreateQueryBuilder createPoll({required String question}) {
    return PollCreateQueryBuilder(serviceLocator(), question);
  }
}
