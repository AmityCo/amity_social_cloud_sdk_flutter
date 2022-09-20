import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class GetUserFollowersUsecase extends UseCase<
    PageListData<List<AmityFollowRelationship>, String>, FollowRequest> {
  final FollowRepo followRepo;
  final AmityFollowRelationshipComposerUsecase
      amityFollowRelationshipComposerUsecase;
  GetUserFollowersUsecase(
      {required this.followRepo,
      required this.amityFollowRelationshipComposerUsecase});

  @override
  Future<PageListData<List<AmityFollowRelationship>, String>> get(
      FollowRequest params) async {
    final followers = await followRepo.getFollower(params);
    final followersComposed = await Stream.fromIterable(followers.data)
        .asyncMap((element) async =>
            await amityFollowRelationshipComposerUsecase.get(element))
        .toList();
    return followers.withItem1(followersComposed);
  }
}
