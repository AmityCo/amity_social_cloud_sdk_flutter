import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class PostFlagUsecase extends UseCase<bool, String> {
  final PostRepo postRepo;

  PostFlagUsecase({required this.postRepo});

  @override
  Future<bool> get(String params) {
    return postRepo.flagPost(params);
  }
}
