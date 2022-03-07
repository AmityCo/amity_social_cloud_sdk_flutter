import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/domain/domain.dart';

class PostUnflagUsecase extends UseCase<bool, String> {
  final PostRepo postRepo;

  PostUnflagUsecase({required this.postRepo});

  @override
  Future<bool> get(String params) {
    return postRepo.unflagPost(params);
  }

  @override
  Stream<bool> listen(String params) {
    // TODO: implement listen
    throw UnimplementedError();
  }
}
