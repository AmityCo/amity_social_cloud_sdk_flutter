import 'package:amity_sdk/src/core/model/api_request/create_poll_request.dart';
import 'package:amity_sdk/src/core/model/api_request/poll_vote_request.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/model/amity_poll/amity_poll_post.dart';
import 'package:amity_sdk/src/domain/repo/poll_repo.dart';

/// Poll Repo Impl
class PollRepoImpl extends PollRepo {
  /// Common Db Adapter
  final DbAdapterRepo dbAdapterRepo;

  /// Poll Api Interface
  final PollApiInterface pollApiInterface;

  /// init Post Repo
  PollRepoImpl({required this.dbAdapterRepo, required this.pollApiInterface});

  @override
  Future<AmityPoll> getPollByIdFromDb(String pollId) async {
    return dbAdapterRepo.pollDbAdapter
        .getPollEntity(pollId)
        .convertToAmityPoll();
  }

  @override
  Future<AmityPoll> createPoll(CreatePollRequest request) async {
    final data = await pollApiInterface.createPoll(request);

    final amityPolls = await data.saveToDb<AmityPoll>(dbAdapterRepo);

    return (amityPolls as List).first;
  }

  @override
  Future<AmityPoll> votePoll(PollVoteRequest request) async {
    final data = await pollApiInterface.votePoll(request);

    /// this will update the poll hive entity and poll answer entity
    final amityPolls = await data.saveToDb<AmityPoll>(dbAdapterRepo);

    return (amityPolls as List).first;
  }

  @override
  Future<AmityPoll> deleteVotePoll(PollVoteRequest request) async {
    throw UnimplementedError();
    // final data = await pollApiInterface.deleteVotePoll(request);

    // final amityPolls = await data.saveToDb<AmityPoll>(dbAdapterRepo);

    // return (amityPolls as List).first;
  }

  @override
  Future<bool> deletePollById(String pollId) async {
    final data =
        await pollApiInterface.deleteVotePoll(PollVoteRequest(pollId: pollId));

    ///Get the post from DB and update the delete flag to true
    final amityPollDb = dbAdapterRepo.pollDbAdapter.getPollEntity(pollId);

    amityPollDb
      ..isDeleted = true
      ..save();

    return data;
  }
}
