import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/domain/repo/poll_repo.dart';

/// Get Poll Use Case
class GetPollUseCase extends UseCase<AmityPoll, String> {
  /// Poll Repo
  final PollRepo pollRepo;

  /// Init Get Post Usecase
  GetPollUseCase({required this.pollRepo});
  @override
  Future<AmityPoll> get(String params) {
    return pollRepo.getPollByIdFromDb(params);
  }

  @override
  Stream<AmityPoll> listen(String params) {
    // TODO: implement listen
    throw UnimplementedError();
  }
}
