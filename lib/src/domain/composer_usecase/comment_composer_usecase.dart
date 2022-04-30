import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class CommentComposerUsecase extends UseCase<AmityComment, AmityComment> {
  final CommentRepo commentRepo;
  final UserRepo userRepo;
  final UserComposerUsecase userComposerUsecase;

  CommentComposerUsecase({
    required this.commentRepo,
    required this.userRepo,
    required this.userComposerUsecase,
  });
  @override
  Future<AmityComment> get(AmityComment params) async {
    //Compose child comment
    if (params.repliesId != null && params.repliesId!.isNotEmpty) {
      //Add Child Amity Comment
      params.latestReplies = await Stream.fromIterable(params.repliesId!)
          .asyncMap((element) async =>
              await commentRepo.getCommentByIdFromDb(element))
          .toList();
      //Compose Child Amity Comment
      params.latestReplies = await Stream.fromIterable(params.latestReplies!)
          .asyncMap((element) async => await get(element))
          .toList();
    }

    //Compose the user
    params.user = await userRepo.getUserByIdFromDb(params.userId!);
    params.user = await userComposerUsecase.get(params.user!);
    return params;
  }

  @override
  Stream<AmityComment> listen(AmityComment params) {
    // TODO: implement listen
    throw UnimplementedError();
  }
}
