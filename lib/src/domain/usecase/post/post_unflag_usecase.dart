import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class PostUnflagUsecase extends UseCase<bool, String> {
  final PostRepo postRepo;

  PostUnflagUsecase({required this.postRepo});

  @override
  Future<bool> get(String params) {
    return postRepo.unflagPost(params);
  }
}
