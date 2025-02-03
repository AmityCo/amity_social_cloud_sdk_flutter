import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// [PostComposerUsecase]
class PostComposerUsecase extends UseCase<AmityPost, AmityPost> {
  /// User Repo
  final UserRepo userRepo;

  /// Post Repo
  final PostRepo postRepo;

  /// Comment Repo
  final CommentRepo commentRepo;

  /// User Composer UseCase
  final UserComposerUsecase userComposerUsecase;

  /// File Composer UseCase
  final PostFileComposerUsecase fileComposerUsecase;

  /// Community Repo
  final CommunityRepo communityRepo;

  /// Community Composer Usecase
  final CommunityComposerUsecase communityComposerUsecase;

  final PollRepo pollRepo;

  /// Community Member Usecase
  CommunityMemberRepo communityMemberRepo;

  /// init [PostComposerUsecase]
  PostComposerUsecase(
      {required this.userRepo,
      required this.postRepo,
      required this.commentRepo,
      required this.userComposerUsecase,
      required this.fileComposerUsecase,
      required this.communityRepo,
      required this.communityComposerUsecase,
      required this.communityMemberRepo,
      required this.pollRepo});

  @override
  Future<AmityPost> get(AmityPost params) async {
    //Compose Target User/Community
    final target = params.target;
    if (target is UserTarget && target.targetUserId != null) {
      target.targetUser =
          await userRepo.getUserByIdFromDb(target.targetUserId!);
      target.targetUser = await userComposerUsecase.get(target.targetUser!);
    } else if (target is CommunityTarget) {
      var targetCommunityId = target.targetCommunityId;
      if (targetCommunityId != null) {
        var targetCommunity =
            await communityRepo.getCommunityById(targetCommunityId);
        if (targetCommunity != null) {
          target.targetCommunity =
              await communityComposerUsecase.get(targetCommunity);
          if (params.postedUserId != null) {
            target.postedCommunityMember = await communityMemberRepo
                .getMemberOptional(targetCommunityId, params.postedUserId!);
          }
        }
      }
    }

    //Add File url to DataType != TEXT
    final data = params.data;
    if (data != null &&
        (data is ImageData || data is VideoData || data is FileData)) {
      params.data = await fileComposerUsecase.get(data);
    }

    if (data != null && data is PollData) {
      data.poll = await pollRepo.getPollByIdFromDb(data.pollId);
      params.data = data;
    }

    //Compose latest comment
    if (params.latestCommentIds != null &&
        params.latestCommentIds!.isNotEmpty) {
      params.latestComments =
          await Stream.fromIterable(params.latestCommentIds!)
              .asyncMap((element) async {
                AmityComment? comment =
                    await commentRepo.getCommentByIdFromDb(element);
                var commentUserId = comment?.userId;
                if (comment != null && commentUserId != null) {
                  var commentUser =
                      await userRepo.getUserByIdFromDb(commentUserId);
                  comment.user = await userComposerUsecase.get(commentUser);
                }
                return comment;
              })
              .where((element) => element != null)
              .cast<AmityComment>()
              .toList();
    }

    //Compose Children post
    if (params.childrenPostIds != null && params.childrenPostIds!.isNotEmpty) {
      //Add Child Amity Post
      params.children = await Stream.fromIterable(params.childrenPostIds!)
          .asyncMap(
              (element) async => await postRepo.getPostByIdFromDb(element))
          .toList();
      //Compose Child Amity Post
      params.children = await Stream.fromIterable(params.children!)
          .asyncMap((element) async => await get(element))
          .toList();
    }

    params.postedUser = await userRepo.getUserByIdFromDb(params.postedUserId!);
    params.postedUser = await userComposerUsecase.get(params.postedUser!);

    ///Compose Mention
    for (AmityMentionee mention in (params.mentionees ?? [])) {
      mention.user = await userRepo.getUserByIdFromDb(mention.userId);
      mention.user = await userComposerUsecase.get(mention.user!);
    }

    return params;
  }
}
