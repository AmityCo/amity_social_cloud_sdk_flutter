import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/domain/domain.dart';

class CommentQueryUsecase
    extends UseCase<List<AmityComment>, GetCommentRequest> {
  final CommentRepo commentRepo;
  final CommentComposerUsecase commentComposerUsecase;

  CommentQueryUsecase(
      {required this.commentRepo, required this.commentComposerUsecase});

  @override
  Future<List<AmityComment>> get(GetCommentRequest params) {
    final data = commentRepo.queryComment(params);
    return data;
  }

  Future<Tuple2<List<AmityComment>, String>> getPagingData(
      GetCommentRequest params) async {
    final data = await commentRepo.queryCommentPagingData(params);

    //Composer usecase to fill in the details
    final amityComposedPost = await Stream.fromIterable(data.item1)
        .asyncMap((event) => commentComposerUsecase.get(event))
        .toList();

    //Replace the original data with compose data
    return data.withItem1(amityComposedPost);
  }

  @override
  Stream<List<AmityComment>> listen(GetCommentRequest params) {
    // TODO: implement listen
    throw UnimplementedError();
  }
}
