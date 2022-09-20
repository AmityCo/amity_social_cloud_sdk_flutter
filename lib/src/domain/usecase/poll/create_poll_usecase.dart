import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/domain/repo/poll_repo.dart';

/// Get Poll Use Case
class CreatePollUseCase extends UseCase<AmityPoll, CreatePollRequest> {
  /// Poll Repo
  final PollRepo pollRepo;

  /// Init Get Post Usecase
  CreatePollUseCase({required this.pollRepo});
  @override
  Future<AmityPoll> get(CreatePollRequest params) {
    return pollRepo.createPoll(params);
  }
}
