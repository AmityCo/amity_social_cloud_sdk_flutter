import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// Reaction Repo Impl for Post & Comment
class ReactionRepoImpl extends ReactionRepo {
  /// Reaction API interface
  final ReactionApiInterface reactionApiInterface;

  /// Post Db Adapter
  final PostDbAdapter postDbAdapter;

  /// Comment Db Adapter
  final CommentDbAdapter commentDbAdapter;

  /// Reaction  Db Adapter
  final ReactionDbAdapter reactionDbAdapter;

  /// User Db Adapter
  final UserDbAdapter userDbAdapter;

  /// Init ReactionRepoImpl
  ReactionRepoImpl({
    required this.reactionApiInterface,
    required this.postDbAdapter,
    required this.commentDbAdapter,
    required this.reactionDbAdapter,
    required this.userDbAdapter,
  });

  @override
  Future addReaction(ReactionRequest request) async {
    await reactionApiInterface.addReaction(request);

    //Add Rection from local Amity Post
    //1. Added to my reaction
    //2. Update the reaction count
    //3. Update the reaction map
    if (request.referenceType == AmityReactionReferenceType.POST.value) {
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
    if (request.referenceType == AmityReactionReferenceType.COMMENT.value) {
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
    if (request.referenceType == AmityReactionReferenceType.POST.value) {
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
    if (request.referenceType == AmityReactionReferenceType.COMMENT.value) {
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

  @override
  Future<PageListData<List<AmityReaction>, String>> getReaction(
      GetReactionRequest request) async {
    final data = await reactionApiInterface.getReaction(request);

    //Convert to Reaction Hive Entity
    final reactionHiveEntities = data.results.reactions.first.reactors
        .map((e) => e.convertToReactionHiveEntity(
            data.results.reactions.first.referenceId,
            data.results.reactions.first.referenceType))
        .toList();

    //Convert to User Hive Entity
    final userHiveEntities =
        data.results.users.map((e) => e.convertToUserHiveEntity()).toList();

    //Save the reaction
    Stream.fromIterable(reactionHiveEntities).asyncMap(
      (event) async => await reactionDbAdapter.saveReactionEntity(event),
    );

    //Save the user
    Stream.fromIterable(userHiveEntities).asyncMap(
      (event) async => await userDbAdapter.saveUserEntity(event),
    );

    return PageListData(
        reactionHiveEntities.map((e) => e.convertToAmityReaction()).toList(),
        data.paging.next ?? '');
  }
}
