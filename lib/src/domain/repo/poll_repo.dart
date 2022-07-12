import 'package:amity_sdk/amity_sdk.dart';

/// Abs layer for Poll Repo
abstract class PollRepo {
  Future<AmityPoll> getPollByIdFromDb(String pollId);
}
