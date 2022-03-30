import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/domain/composer_usecase/community_composer_usecase.dart';
import 'package:amity_sdk/domain/composer_usecase/post_file_composer_usecase.dart';
import 'package:amity_sdk/domain/composer_usecase/user_compose_usecase.dart';
import 'package:amity_sdk/domain/domain.dart';

class PostComposerUsecase extends UseCase<AmityPost, AmityPost> {
  final UserRepo userRepo;
  final PostRepo postRepo;
  final CommentRepo commentRepo;
  final UserComposerUsecase userComposerUsecase;
  final PostFileComposerUsecase fileComposerUsecase;
  final CommunityRepo communityRepo;
  final CommunityComposerUsecase communityComposerUsecase;
  PostComposerUsecase(
      {required this.userRepo,
      required this.postRepo,
      required this.commentRepo,
      required this.userComposerUsecase,
      required this.fileComposerUsecase,
      required this.communityRepo,
      required this.communityComposerUsecase});
  @override
  Future<AmityPost> get(AmityPost params) async {
    //Compose Target User/Community
    final target = params.target;
    if (target is UserTarget && target.targetUserId != null) {
      target.targetUser =
          await userRepo.getUserByIdFromDb(target.targetUserId!);
      target.targetUser = await userComposerUsecase.get(target.targetUser!);
    } else if (target is CommunityTarget) {
      target.targetCommunity =
          await communityRepo.getCommunityById(target.targetCommunityId!);
      target.targetCommunity =
          await communityComposerUsecase.get(target.targetCommunity!);
    }

    //Add File url to DataType != TEXT
    final data = params.data;
    if (data != null && data is! TextData) {
      params.data = await fileComposerUsecase.get(data);
    }

    //Compose latest comment
    if (params.latestCommentIds != null &&
        params.latestCommentIds!.isNotEmpty) {
      params.latestComments =
          await Stream.fromIterable(params.latestCommentIds!)
              .asyncMap((element) async =>
                  await commentRepo.getCommentByIdFromDb(element))
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

    return params;
  }

  @override
  Stream<AmityPost> listen(AmityPost params) {
    // TODO: implement listen
    throw UnimplementedError();
  }
}
