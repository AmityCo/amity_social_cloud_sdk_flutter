import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/domain/domain.dart';
import 'package:amity_sdk/domain/usecase/post/post_delete_usecase.dart';
import 'package:amity_sdk/public/query_builder/comment/comment_create_query_builder.dart';
import 'package:amity_sdk/public/query_builder/post/post_flag_query_builder.dart';
import 'package:amity_sdk/public/query_builder/post/post_update_query_builder.dart';
import 'package:amity_sdk/public/query_builder/reaction/reaction_query_builder.dart';

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

  AmityTextPostUpdator edit() {
    return AmityTextPostUpdator(useCase: serviceLocator(), targetId: postId!);
  }

  Future delete({bool hardDelete = false}) {
    return serviceLocator<PostDeleteUseCase>().get(postId!);
  }
}
