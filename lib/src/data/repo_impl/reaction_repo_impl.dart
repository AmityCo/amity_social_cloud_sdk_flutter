import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class ReactionRepoImpl extends ReactionRepo {
  final ReactionApiInterface reactionApiInterface;
  final PostDbAdapter postDbAdapter;
  final CommentDbAdapter commentDbAdapter;

  ReactionRepoImpl(
      {required this.reactionApiInterface,
      required this.postDbAdapter,
      required this.commentDbAdapter});

  @override
  Future addReaction(ReactionRequest request) async {
    await reactionApiInterface.addReaction(request);

    //Add Rection from local Amity Post
    //1. Added to my reaction
    //2. Update the reaction count
    //3. Update the reaction map
    if (request.referenceType == ReactionReferenceType.POST.value) {
      final amityPost = postDbAdapter.getPostEntity(request.referenceId);

      amityPost.myReactions ??= [];
      amityPost.myReactions!.add(request.reactionName);

      amityPost.reactionsCount = (amityPost.reactionsCount ?? 0) + 1;

      amityPost.reactions ??= {};
      amityPost.reactions![request.reactionName] =
          (amityPost.reactions![request.reactionName] ?? 0) + 1;

      postDbAdapter.savePostEntity(amityPost);
    }

    //Add Rection from local Amity Comment
    if (request.referenceType == ReactionReferenceType.COMMENT.value) {
      final amityComment =
          commentDbAdapter.getCommentEntity(request.referenceId);

      amityComment.myReactions ??= [];
      amityComment.myReactions!.add(request.reactionName);

      amityComment.reactionsCount = (amityComment.reactionsCount ?? 0) + 1;

      amityComment.reactions ??= {};
      amityComment.reactions![request.reactionName] =
          (amityComment.reactions![request.reactionName] ?? 0) + 1;

      amityComment.save();
    }
  }

  @override
  Future removeReaction(ReactionRequest request) async {
    await reactionApiInterface.removeReaction(request);

    //Remove Reaction from Local Amity Post
    if (request.referenceType == ReactionReferenceType.POST.value) {
      final amityPost = postDbAdapter.getPostEntity(request.referenceId);

      amityPost.myReactions ??= [];
      amityPost.myReactions!.remove(request.reactionName);

      amityPost.reactionsCount = (amityPost.reactionsCount ?? 0) - 1;

      amityPost.reactions ??= {};
      amityPost.reactions![request.reactionName] =
          (amityPost.reactions![request.reactionName] ?? 0) - 1;

      postDbAdapter.savePostEntity(amityPost);
    }

    //Remove Rection from local Amity Comment
    if (request.referenceType == ReactionReferenceType.COMMENT.value) {
      final amityComment =
          commentDbAdapter.getCommentEntity(request.referenceId);

      amityComment.myReactions ??= [];
      amityComment.myReactions!.remove(request.reactionName);

      amityComment.reactionsCount = (amityComment.reactionsCount ?? 0) - 1;

      amityComment.reactions ??= {};
      amityComment.reactions![request.reactionName] =
          (amityComment.reactions![request.reactionName] ?? 0) - 1;

      commentDbAdapter.saveCommentEntity(amityComment);
    }
  }
}
