import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class PostDeleteUseCase extends UseCase<void, String> {
  final PostRepo postRepo;

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
