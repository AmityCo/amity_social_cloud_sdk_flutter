import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/repo/poll_repo.dart';

/// Get Poll Use Case
class DeletePollUseCase extends UseCase<bool, String> {
  /// Poll Repo
  final PollRepo pollRepo;

  /// Init Get Post Usecase
  DeletePollUseCase({required this.pollRepo});

  @override
  Future<bool> get(String params) {
    return pollRepo.deletePollById(params);
  }

  @override
  Stream<bool> listen(String params) {
    // TODO: implement listen
    throw UnimplementedError();
  }
}
