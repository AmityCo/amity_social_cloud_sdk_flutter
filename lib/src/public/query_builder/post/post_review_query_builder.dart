import 'package:amity_sdk/src/domain/domain.dart';

class PostReviewQueryBuilder {
  final PostApproveUsecase _postApproveUsecase;
  final PostDeclineUsecase _postDeclineUsecase;
  final String _postId;
  PostReviewQueryBuilder(
      {required PostApproveUsecase postApproveUsecase,
      required PostDeclineUsecase postDeclineUsecase,
      required String postId})
      : _postApproveUsecase = postApproveUsecase,
        _postDeclineUsecase = postDeclineUsecase,
        _postId = postId;

  /* begin_public_function 
  id: post.approve
  */
  Future<bool> approve() {
    return _postApproveUsecase.get(_postId);
  }
  /* end_public_function */

  /* begin_public_function 
  id: post.decline
  */
  Future<bool> decline() {
    return _postDeclineUsecase.get(_postId);
  }
  /* end_public_function */
}
