import 'package:amity_sdk/core/usercase/usecase.dart';
import 'package:amity_sdk/domain/model/amity_post.dart';
import 'package:amity_sdk/domain/repo/post_repo.dart';

class GetPostByIdUseCase extends UseCase<AmityPost, String> {
  final PostRepo postRepo;

  GetPostByIdUseCase({required this.postRepo});

  @override
  Future<AmityPost> get(String params) async {
    //1. Get the public model (AmityPost) from data layer
    //2. Use the composer usecase to compose the public model (fill the detail)

    final data = await postRepo.getPostById(params);
    return Future.value(data);
  }

  @override
  Stream<AmityPost> listen(String params) {
    throw UnimplementedError();
  }
}
