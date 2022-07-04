import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class GetUserFollowingsUsecase extends UseCase<
    PageListData<List<AmityFollowRelationship>, String>, FollowRequest> {
  final FollowRepo followRepo;
  final AmityFollowRelationshipComposerUsecase
      amityFollowRelationshipComposerUsecase;
  GetUserFollowingsUsecase(
      {required this.followRepo,
      required this.amityFollowRelationshipComposerUsecase});

  @override
  Future<PageListData<List<AmityFollowRelationship>, String>> get(
      FollowRequest params) async {
    final followings = await followRepo.getFollowing(params);
    final followingsComposed = await Stream.fromIterable(followings.data)
        .asyncMap((element) async =>
            await amityFollowRelationshipComposerUsecase.get(element))
        .toList();
    return followings.withItem1(followingsComposed);
  }

  @override
  Stream<PageListData<List<AmityFollowRelationship>, String>> listen(
      FollowRequest params) {
    // TODO: implement listen
    throw UnimplementedError();
  }
}
