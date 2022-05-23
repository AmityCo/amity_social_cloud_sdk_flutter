import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/public/query_builder/comment/comment_create_query_builder.dart';
import 'package:amity_sdk/src/public/query_builder/post/post_flag_query_builder.dart';
import 'package:amity_sdk/src/public/query_builder/post/post_text_editor.dart';
import 'package:amity_sdk/src/public/query_builder/reaction/reaction_query_builder.dart';

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

  AmityTextPostEditor edit() {
    return AmityTextPostEditor(useCase: serviceLocator(), targetId: postId!);
  }

  Future delete({bool hardDelete = false}) {
    return serviceLocator<PostDeleteUseCase>().get(postId!);
  }
}
