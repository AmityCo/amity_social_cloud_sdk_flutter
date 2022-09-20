import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class PostDeclineUsecase extends UseCase<bool, String> {
  final PostRepo postRepo;

  PostDeclineUsecase({required this.postRepo});

  @override
  Future<bool> get(String params) {
    return postRepo.declinePost(params);
  }
}
