import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/domain/usecase/community/member/community_member_get_optional_usercase.dart';

class CommentComposerUsecase extends UseCase<AmityComment, AmityComment> {
  final CommentRepo commentRepo;
  final UserRepo userRepo;
  final CommunityMemberGetOptionalUsecase communityMemberGetOptionalUsecase;
  final UserComposerUsecase userComposerUsecase;

  /// Comment File Composer Usecase
  final CommentFileComposerUsecase commentFileComposerUsecase;

  CommentComposerUsecase(
      {required this.commentRepo,
      required this.userRepo,
      required this.userComposerUsecase,
      required this.communityMemberGetOptionalUsecase,
      required this.commentFileComposerUsecase});
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

    ///Compose Mention
    for (AmityMentionee mention in (params.mentionees ?? [])) {
      mention.user = await userRepo.getUserByIdFromDb(mention.userId);
      mention.user = await userComposerUsecase.get(mention.user!);
    }

    /// Attachment file composer
    if (params.attachments?.isNotEmpty ?? false) {
      params.attachments = await Stream.fromIterable(params.attachments!)
          .asyncMap(
              (element) async => await commentFileComposerUsecase.get(element))
          .toList();
    }

    /// Compose AmityCommentTarget for type CommunityComment
    if (params.target is CommunityCommentTarget) {
      var communtiyTarget = params.target as CommunityCommentTarget;
      if (communtiyTarget.communityId != null && params.userId != null) {
        final communityMember = await communityMemberGetOptionalUsecase
            .communityMemberRepo
            .getMemberOptional(communtiyTarget.communityId!, params.userId!);
        if (communityMember != null) {
          communtiyTarget.creatorMember = communityMember;
          params.target = communtiyTarget;
        }
      }
    }

    return params;
  }
}
