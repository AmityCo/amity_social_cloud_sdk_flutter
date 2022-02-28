import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/core/model/api_request/create_comment_request.dart';
import 'package:amity_sdk/domain/domain.dart';
import 'package:amity_sdk/domain/model/amity_comment.dart';

class CommentCreateUseCase extends UseCase<AmityComment, CreateCommentRequest> {
  final CommentRepo commentRepo;

  CommentCreateUseCase({required this.commentRepo});
  @override
  Future<AmityComment> get(CreateCommentRequest params) {
    return commentRepo.createComment(params);
  }

  @override
  Stream<AmityComment> listen(CreateCommentRequest params) {
    // TODO: implement listen
    throw UnimplementedError();
  }
}
