import 'package:amity_sdk/src/domain/domain.dart';

class PostFlagQueryBuilder {
  final PostFlagUsecase _postFlagUsecase;
  final PostUnflagUsecase _postUnflagUsecase;
  final String _postId;
  PostFlagQueryBuilder(
      {required PostFlagUsecase postFlagUsecase,
      required PostUnflagUsecase postUnflagUsecase,
      required String postId})
      : _postFlagUsecase = postFlagUsecase,
        _postUnflagUsecase = postUnflagUsecase,
        _postId = postId;
  Future<bool> flag() {
    return _postFlagUsecase.get(_postId);
  }

  Future<bool> unflag() {
    return _postUnflagUsecase.get(_postId);
  }
}
