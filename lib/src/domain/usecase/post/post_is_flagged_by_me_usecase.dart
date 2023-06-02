import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/public/public.dart';

class PostIsFlaggedByMeUsecase extends UseCase<bool, String> {
  final PostRepo postRepo;
  PostIsFlaggedByMeUsecase({required this.postRepo});

  @override
  Future<bool> get(String params) async {
    final amityPost = await postRepo.getPostById(params);
    if (amityPost.hashFlag == null) return false;
    return (amityPost.flaggedByMe ?? false) ||
        BloomFilter(
                hash: (amityPost.hashFlag!['hash'] as String),
                m: amityPost.hashFlag!['bits'] as int,
                k: amityPost.hashFlag!['hashes'] as int)
            .mightContains(AmityCoreClient.getUserId());
  }
}
