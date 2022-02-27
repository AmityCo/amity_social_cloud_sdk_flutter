import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/core/model/api_request/get_comment_request.dart';
import 'package:amity_sdk/domain/domain.dart';

class CommentQueryUsecase
    extends UseCase<List<AmityComment>, GetCommentRequest> {
  final CommentRepo commentRepo;

  CommentQueryUsecase({required this.commentRepo});

  @override
  Future<List<AmityComment>> get(GetCommentRequest params) {
    final data = commentRepo.queryComment(params);
    return data;
  }

  @override
  Stream<List<AmityComment>> listen(GetCommentRequest params) {
    // TODO: implement listen
    throw UnimplementedError();
  }
}
