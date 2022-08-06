import 'dart:async';
import 'dart:convert';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/public/public.dart';

/// Amity Post Extension
extension AmityPostExtension on AmityPost {
  /// React On Amity Post
  AddReactionQueryBuilder react() {
    return AddReactionQueryBuilder(
        addReactionUsecase: serviceLocator(),
        removeReactionUsecase: serviceLocator(),
        referenceType: AmityReactionReferenceType.POST.value,
        referenceId: postId!);
  }

  /// Get Amity Post Reaction
  GetReactionQueryBuilder getReaction() {
    return GetReactionQueryBuilder.post(postId: postId!);
  }

  /// Get Amity Post Comment
  AmityCommentCreateTargetSelector comment() {
    return AmityCommentCreateTargetSelector(
      useCase: serviceLocator(),
    ).post(postId!);
  }

  /// Amity Post Report
  PostFlagQueryBuilder report() {
    return PostFlagQueryBuilder(
        postFlagUsecase: serviceLocator(),
        postUnflagUsecase: serviceLocator(),
        postId: postId!);
  }

  /// Edit Amity Post
  AmityTextPostEditorBuilder edit() {
    return AmityTextPostEditorBuilder(
        useCase: serviceLocator(), targetId: postId!);
  }

  /// Delete Amity Post
  Future delete({bool hardDelete = false}) {
    return serviceLocator<PostDeleteUseCase>().get(postId!);
  }

  /// Approve Amity Post
  Future<bool> approve() {
    return PostReviewQueryBuilder(
            postApproveUsecase: serviceLocator(),
            postDeclineUsecase: serviceLocator(),
            postId: postId!)
        .approve();
  }

  /// Decline Amity Post
  Future<bool> decline() {
    return PostReviewQueryBuilder(
            postApproveUsecase: serviceLocator(),
            postDeclineUsecase: serviceLocator(),
            postId: postId!)
        .decline();
  }

  /// Listen Post Id
  Stream<AmityPost> get listen {
    StreamController<AmityPost> controller = StreamController<AmityPost>();

    serviceLocator<PostDbAdapter>().listenPostEntity(postId!).listen((event) {
      final updateAmityPost = event.convertToAmityPost();

      //TOOD: Good idea would be have compose method inside the object itself
      serviceLocator<PostComposerUsecase>().get(updateAmityPost).then(
            (value) => controller.add(value),
          );
    });

    return controller.stream;
  }

  /// check if post is flagged by me
  bool isFlaggedByMeCheck() {
    if (hashFlag == null) return false;
    return BloomFilter(
            buckets: base64.decode((hashFlag!['hash'] as String)),
            m: hashFlag!['bits'] as int,
            k: hashFlag!['hashes'] as int)
        .mightContains(AmityCoreClient.getUserId());
  }
}
