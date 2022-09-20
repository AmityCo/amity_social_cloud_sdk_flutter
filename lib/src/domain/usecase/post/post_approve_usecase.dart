import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class PostApproveUsecase extends UseCase<bool, String> {
  final PostRepo postRepo;

  PostApproveUsecase({required this.postRepo});

  @override
  Future<bool> get(String params) {
    return postRepo.approvePost(params);
  }
}
