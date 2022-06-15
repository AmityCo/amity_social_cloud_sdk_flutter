import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/public/public.dart';

extension AmityPostExtension on AmityPost {
  AddReactionQueryBuilder react() {
    return AddReactionQueryBuilder(
        addReactionUsecase: serviceLocator(),
        removeReactionUsecase: serviceLocator(),
        referenceType: ReactionReferenceType.POST.value,
        referenceId: postId!);
  }

  AmityCommentCreateTargetSelector comment() {
    return AmityCommentCreateTargetSelector(
      useCase: serviceLocator(),
    ).post(postId!);
  }

  PostFlagQueryBuilder report() {
    return PostFlagQueryBuilder(
        postFlagUsecase: serviceLocator(),
        postUnflagUsecase: serviceLocator(),
        postId: postId!);
  }

  AmityTextPostEditorBuilder edit() {
    return AmityTextPostEditorBuilder(
        useCase: serviceLocator(), targetId: postId!);
  }

  Future delete({bool hardDelete = false}) {
    return serviceLocator<PostDeleteUseCase>().get(postId!);
  }

  Future<bool> approve() {
    return PostReviewQueryBuilder(
            postApproveUsecase: serviceLocator(),
            postDeclineUsecase: serviceLocator(),
            postId: postId!)
        .approve();
  }

  Future<bool> decline() {
    return PostReviewQueryBuilder(
            postApproveUsecase: serviceLocator(),
            postDeclineUsecase: serviceLocator(),
            postId: postId!)
        .decline();
  }
}
