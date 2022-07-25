import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// Post Delete Usecase
class PostDeleteUseCase extends UseCase<void, String> {
  /// Post Repo
  final PostRepo postRepo;

  /// Init [PostDeleteUseCase]
  PostDeleteUseCase({required this.postRepo});

  @override
  Future get(String params) {
    return postRepo.deletePostById(params);
  }

  @override
  Stream<void> listen(String params) {
    throw UnimplementedError();
  }
}
