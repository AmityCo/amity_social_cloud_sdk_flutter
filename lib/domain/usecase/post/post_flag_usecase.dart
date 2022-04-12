import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/domain/domain.dart';

class PostFlagUsecase extends UseCase<bool, String> {
  final PostRepo postRepo;

  PostFlagUsecase({required this.postRepo});

  @override
  Future<bool> get(String params) {
    return postRepo.flagPost(params);
  }

  @override
  Stream<bool> listen(String params) {
    // TODO: implement listen
    throw UnimplementedError();
  }
}
