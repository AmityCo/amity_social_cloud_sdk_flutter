import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// Reaction Repo Impl for Post & Comment
class ReactionRepoImpl extends ReactionRepo {
  /// Reaction API interface
  final ReactionApiInterface reactionApiInterface;

  /// Common Db Adapter
  final DbAdapterRepo dbAdapterRepo;

  /// Init ReactionRepoImpl
  ReactionRepoImpl({
    required this.reactionApiInterface,
    required this.dbAdapterRepo,
  });

  @override
  Future<T> addReaction<T>(ReactionRequest request) async {
    ///Add Rection from local Amity Post
    ///1. Added to my reaction
    ///2. Update the reaction count
    ///3. Update the reaction map
    /// CHANGE: 11Oct 2021
    /// Since now RTE event for message is enable,
    /// we need to upload the local first and make the API call.
    /// After the API call, we gonna recevive RTE callback,which will
    /// overwrite the message data.
    if (request.referenceType == AmityReactionReferenceType.POST.value) {
      final amityPost =
          dbAdapterRepo.postDbAdapter.getPostEntity(request.referenceId)!;

      try {
        final amityPostLocalCopy = amityPost.copyWith();
        amityPostLocalCopy.myReactions ??= [];
        amityPostLocalCopy.myReactions!.add(request.reactionName);

        amityPostLocalCopy.reactionsCount =
            (amityPostLocalCopy.reactionsCount ?? 0) + 1;

        amityPostLocalCopy.reactions ??= {};
        amityPostLocalCopy.reactions![request.reactionName] =
            (amityPostLocalCopy.reactions![request.reactionName] ?? 0) + 1;

        await dbAdapterRepo.postDbAdapter.savePostEntity(amityPostLocalCopy);

        await reactionApiInterface.addReaction(request);

        return amityPostLocalCopy.convertToAmityPost() as T;
      } catch (error) {
        await dbAdapterRepo.postDbAdapter.savePostEntity(amityPost);
        rethrow;
      }
    }

    //Add Rection from local Amity Comment
    if (request.referenceType == AmityReactionReferenceType.COMMENT.value) {
      final amityComment =
          dbAdapterRepo.commentDbAdapter.getCommentEntity(request.referenceId)!;
      try {
        final amityCommentLocalCopy = amityComment.copyWith();
        amityCommentLocalCopy.myReactions ??= [];
        amityCommentLocalCopy.myReactions!.add(request.reactionName);

        amityCommentLocalCopy.reactionsCount =
            (amityCommentLocalCopy.reactionsCount ?? 0) + 1;

        amityCommentLocalCopy.reactions ??= {};
        amityCommentLocalCopy.reactions![request.reactionName] =
            (amityCommentLocalCopy.reactions![request.reactionName] ?? 0) + 1;

        await dbAdapterRepo.commentDbAdapter
            .saveCommentEntity(amityCommentLocalCopy);

        await reactionApiInterface.addReaction(request);

        return amityCommentLocalCopy.convertToAmityComment() as T;
      } catch (error) {
        await dbAdapterRepo.commentDbAdapter.saveCommentEntity(amityComment);
        rethrow;
      }
    }

    //Add Rection from local Amity Comment
    if (request.referenceType == AmityReactionReferenceType.MESSAGE.value) {
      final amityMessage =
          dbAdapterRepo.messageDbAdapter.getMessageEntity(request.referenceId)!;
      try {
        final amityMessageLocalCopy = amityMessage.copyWith();
        amityMessageLocalCopy.myReactions ??= [];
        amityMessageLocalCopy.myReactions!.add(request.reactionName);

        /// Updated this information with RTE payload
        amityMessageLocalCopy.reactionsCount =
            (amityMessageLocalCopy.reactionsCount ?? 0) + 1;

        amityMessageLocalCopy.reactions ??= {};
        amityMessageLocalCopy.reactions![request.reactionName] =
            (amityMessageLocalCopy.reactions![request.reactionName] ?? 0) + 1;

        await dbAdapterRepo.messageDbAdapter
            .saveMessageEntity(amityMessageLocalCopy);

        await reactionApiInterface.addReaction(request);

        return amityMessageLocalCopy.convertToAmityMessage() as T;
      } catch (error) {
        await dbAdapterRepo.messageDbAdapter.saveMessageEntity(amityMessage);
        rethrow;
      }
    }

    return Future.value();
  }

  @override
  Future<T> removeReaction<T>(ReactionRequest request) async {
    // await reactionApiInterface.removeReaction(request);

    //Remove Reaction from Local Amity Post
    if (request.referenceType == AmityReactionReferenceType.POST.value) {
      final amityPost =
          dbAdapterRepo.postDbAdapter.getPostEntity(request.referenceId)!;

      try {
        final amityPostLocalCopy = amityPost.copyWith();
        amityPostLocalCopy.myReactions ??= [];
        amityPostLocalCopy.myReactions!.remove(request.reactionName);

        amityPostLocalCopy.reactionsCount =
            (amityPostLocalCopy.reactionsCount ?? 0) - 1;

        amityPostLocalCopy.reactions ??= {};
        amityPost.reactions![request.reactionName] =
            (amityPostLocalCopy.reactions![request.reactionName] ?? 0) - 1;

        await dbAdapterRepo.postDbAdapter.savePostEntity(amityPostLocalCopy);

        await reactionApiInterface.removeReaction(request);

        return amityPostLocalCopy.convertToAmityPost() as T;
      } catch (error) {
        await dbAdapterRepo.postDbAdapter.savePostEntity(amityPost);
        rethrow;
      }
    }

    //Remove Rection from local Amity Comment
    if (request.referenceType == AmityReactionReferenceType.COMMENT.value) {
      final amityComment =
          dbAdapterRepo.commentDbAdapter.getCommentEntity(request.referenceId)!;
      try {
        final amityCommentLocalCopy = amityComment.copyWith();
        amityCommentLocalCopy.myReactions ??= [];
        amityCommentLocalCopy.myReactions!.remove(request.reactionName);

        amityCommentLocalCopy.reactionsCount =
            (amityCommentLocalCopy.reactionsCount ?? 0) - 1;

        amityCommentLocalCopy.reactions ??= {};
        amityCommentLocalCopy.reactions![request.reactionName] =
            (amityCommentLocalCopy.reactions![request.reactionName] ?? 0) - 1;

        await dbAdapterRepo.commentDbAdapter
            .saveCommentEntity(amityCommentLocalCopy);

        await reactionApiInterface.removeReaction(request);

        return amityCommentLocalCopy.convertToAmityComment() as T;
      } catch (error) {
        await dbAdapterRepo.commentDbAdapter.saveCommentEntity(amityComment);
        rethrow;
      }
    }

    //Remove Rection from local Amity Message
    if (request.referenceType == AmityReactionReferenceType.MESSAGE.value) {
      final amityMessage =
          dbAdapterRepo.messageDbAdapter.getMessageEntity(request.referenceId)!;
      try {
        final amityMessageLocalCopy = amityMessage.copyWith();
        amityMessageLocalCopy.myReactions ??= [];
        amityMessageLocalCopy.myReactions!.remove(request.reactionName);

        /// Updated this information with RTE payload
        amityMessageLocalCopy.reactionsCount =
            (amityMessageLocalCopy.reactionsCount ?? 0) - 1;

        amityMessageLocalCopy.reactions ??= {};
        amityMessageLocalCopy.reactions![request.reactionName] =
            (amityMessageLocalCopy.reactions![request.reactionName] ?? 0) - 1;

        await dbAdapterRepo.messageDbAdapter
            .saveMessageEntity(amityMessageLocalCopy);

        await reactionApiInterface.removeReaction(request);

        return amityMessageLocalCopy.convertToAmityMessage() as T;
      } catch (error) {
        await dbAdapterRepo.messageDbAdapter.saveMessageEntity(amityMessage);
        rethrow;
      }
    }

    return Future.value();
  }

  @override
  Future<PageListData<List<AmityReaction>, String>> getReaction(
      GetReactionRequest request) async {
    final data = await reactionApiInterface.getReaction(request);

    //Convert to Reaction Hive Entity
    final reactionHiveEntities = data.reactions.isNotEmpty
        ? data.reactions.first.reactors
            .map((e) => e.convertToReactionHiveEntity(
                data.reactions.first.referenceId,
                data.reactions.first.referenceType))
            .toList()
        : <ReactionHiveEntity>[];

    //Convert to User Hive Entity
    final userHiveEntities =
        data.users.map((e) => e.convertToUserHiveEntity()).toList();

    //Save the reaction
    Stream.fromIterable(reactionHiveEntities).asyncMap(
      (event) async =>
          await dbAdapterRepo.reactionDbAdapter.saveReactionEntity(event),
    );

    //Save the user
    Stream.fromIterable(userHiveEntities).asyncMap(
      (event) async => await dbAdapterRepo.userDbAdapter.saveUserEntity(event),
    );

    return PageListData(
        reactionHiveEntities.map((e) => e.convertToAmityReaction()).toList(),
        data.paging.next ?? '');
  }
}
