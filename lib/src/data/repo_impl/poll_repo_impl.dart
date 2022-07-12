import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/model/amity_poll/amity_poll_post.dart';
import 'package:amity_sdk/src/domain/repo/poll_repo.dart';

/// Poll Repo Impl
class PollRepoImpl extends PollRepo {
  /// Common Db Adapter
  DbAdapterRepo dbAdapterRepo;

  /// init Post Repo
  PollRepoImpl({
    required this.dbAdapterRepo,
  });
  @override
  Future<AmityPoll> getPollByIdFromDb(String pollId) async {
    return dbAdapterRepo.pollDbAdapter
        .getPollEntity(pollId)
        .convertToAmityPoll();
  }
}
