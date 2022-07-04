import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class GetMyFollowersUsecase extends UseCase<
    PageListData<List<AmityFollowRelationship>, String>, FollowRequest> {
  final FollowRepo followRepo;
  final AmityFollowRelationshipComposerUsecase
      amityFollowRelationshipComposerUsecase;
  GetMyFollowersUsecase(
      {required this.followRepo,
      required this.amityFollowRelationshipComposerUsecase});

  @override
  Future<PageListData<List<AmityFollowRelationship>, String>> get(
      FollowRequest params) async {
    final followers = await followRepo.getMyFollower(params);
    final followersComposed = await Stream.fromIterable(followers.data)
        .asyncMap((element) async =>
            await amityFollowRelationshipComposerUsecase.get(element))
        .toList();
    return followers.withItem1(followersComposed);
  }

  @override
  Stream<PageListData<List<AmityFollowRelationship>, String>> listen(
      FollowRequest params) {
    throw UnimplementedError();
  }
}
