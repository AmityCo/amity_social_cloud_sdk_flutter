import 'package:amity_sdk/lib.dart';

class PostDeleteUseCase extends UseCase<void, String> {
  final PostRepo postRepo;

  PostDeleteUseCase({required this.postRepo});
  @override
  Future get(String params) {
    return postRepo.deletePostById(params);
  }

  @override
  Stream<void> listen(String params) {
    // TODO: implement listen
    throw UnimplementedError();
  }
}
