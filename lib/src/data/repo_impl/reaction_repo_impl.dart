import 'dart:math';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/utils/amity_nonce.dart';
import 'package:amity_sdk/src/data/converter/story/story_hive_extension_converter.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/domain/repo/paging_id_repo.dart';
import 'package:collection/collection.dart';

/// Reaction Repo Impl for Post & Comment
class ReactionRepoImpl extends ReactionRepo {
  /// Reaction API interface
  final ReactionApiInterface reactionApiInterface;

  /// Common Db Adapter
  final DbAdapterRepo dbAdapterRepo;
  final PagingIdRepo pagingIdRepo;

  /// Init ReactionRepoImpl
  ReactionRepoImpl({
    required this.reactionApiInterface,
    required this.dbAdapterRepo,
    required this.pagingIdRepo,
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

    //Add Rection from local Amity Comment
    if (request.referenceType == AmityReactionReferenceType.STORY.value) {
      final amityStory =
          dbAdapterRepo.storyDbAdapter.getStoryEntity(request.referenceId)!;
      try {
        final amityStoryLocalCopy = amityStory.copyWith();
        amityStoryLocalCopy.myReactions ??= [];
        amityStoryLocalCopy.myReactions!.add(request.reactionName);

        amityStoryLocalCopy.reactionsCount =
            (amityStoryLocalCopy.reactionsCount ?? 0) + 1;

        amityStoryLocalCopy.reactions ??= {};
        amityStoryLocalCopy.reactions![request.reactionName] =
            (amityStoryLocalCopy.reactions![request.reactionName] ?? 0) + 1;

        await dbAdapterRepo.storyDbAdapter.saveStoryEntity(amityStoryLocalCopy);

        await reactionApiInterface.addReaction(request);
        var amityStoryObject = amityStoryLocalCopy.convertToAmityStory() as T;
        return amityStoryObject;
      } catch (error) {
        await dbAdapterRepo.storyDbAdapter.saveStoryEntity(amityStory);
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
        amityPostLocalCopy.reactions![request.reactionName] =
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

    //Remove Rection from local Amity Message
    if (request.referenceType == AmityReactionReferenceType.STORY.value) {
      final amityStory =
          dbAdapterRepo.storyDbAdapter.getStoryEntity(request.referenceId)!;
      try {
        final amityStoryLocalCopy = amityStory.copyWith();
        amityStoryLocalCopy.myReactions ??= [];
        amityStoryLocalCopy.myReactions!.remove(request.reactionName);

        /// Updated this information with RTE payload
        amityStoryLocalCopy.reactionsCount =
            (amityStoryLocalCopy.reactionsCount ?? 0) - 1;

        amityStoryLocalCopy.reactions ??= {};
        amityStoryLocalCopy.reactions![request.reactionName] =
            (amityStoryLocalCopy.reactions![request.reactionName] ?? 0) - 1;

        await dbAdapterRepo.storyDbAdapter.saveStoryEntity(amityStoryLocalCopy);

        await reactionApiInterface.removeReaction(request);

        return amityStoryLocalCopy.convertToAmityStory() as T;
      } catch (error) {
        await dbAdapterRepo.storyDbAdapter.saveStoryEntity(amityStory);
        rethrow;
      }
    }

    return Future.value();
  }

  @override
  Future<PageListData<List<AmityReaction>, String>> getReaction(
      GetReactionRequest request) async {
    final hash = request.getHashCode();
    final nonce = request.getNonce();
    int nextIndex = 0;
    final isFirstPage =
        request.options?.token == null && (request.options?.limit ?? 0) > 0;
    final data = await reactionApiInterface.getReaction(request);
    final reactions = await _saveDetailsToDb(data);
    if (isFirstPage) {
      await pagingIdRepo.deletePagingIdByHash(nonce.value, hash);
    } else {
      nextIndex = (pagingIdRepo
              .getPagingIdEntities(nonce.value, hash)
              .map((e) => (e.position ?? 0))
              .toList()
              .reduce(max)) +
          1;
    }
    reactions.forEachIndexed((index, element) async {
      final pagingId = PagingIdHiveEntity(
        id: element.reactionId,
        hash: hash,
        nonce: nonce.value,
        position: nextIndex + index,
      );
      await pagingIdRepo.savePagingId(pagingId);
    });

    return PageListData(
        reactions.map((e) => e.convertToAmityReaction()).toList(),
        data.paging.next ?? '');
  }

  Future<List<ReactionHiveEntity>> _saveDetailsToDb(
      GetReactionResponse data) async {
    //Convert to Reaction Hive Entity
    final reactionHiveEntities = data.reactions.isNotEmpty
        ? data.reactions.first.reactors
            .map((e) => e.convertToReactionHiveEntity(
                data.reactions.first.referenceId,
                data.reactions.first.referenceType))
            .toList()
        : <ReactionHiveEntity>[];

    //Save the Reaction Entities
    for (var e in reactionHiveEntities) {
      await dbAdapterRepo.reactionDbAdapter.saveReactionEntity(e);
    }

    //Convert to User Hive Entity
    final userHiveEntities =
        data.users.map((e) => e.convertToUserHiveEntity()).toList();

    //Save the User Entities
    for (var e in userHiveEntities) {
      await dbAdapterRepo.userDbAdapter.saveUserEntity(e);
    }

    return reactionHiveEntities;
  }

  @override
  Stream<List<AmityReaction>> listenReactions(
      RequestBuilder<GetReactionRequest> request) {
    final reactions =
        dbAdapterRepo.reactionDbAdapter.listenReactionEntities(request);
    return reactions
        .map((event) => event.map((e) => e.convertToAmityReaction()).toList());
  }

  @override
  List<ReactionHiveEntity> getReactionEntities(
      RequestBuilder<GetReactionRequest> request) {
    return dbAdapterRepo.reactionDbAdapter.getReactionEntities(request);
  }
}
