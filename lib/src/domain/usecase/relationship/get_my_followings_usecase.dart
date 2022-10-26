import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class GetMyFollowingsUsecase extends UseCase<
    PageListData<List<AmityFollowRelationship>, String>, FollowRequest> {
  final FollowRepo followRepo;
  final AmityFollowRelationshipComposerUsecase
      amityFollowRelationshipComposerUsecase;

  GetMyFollowingsUsecase(
      {required this.followRepo,
      required this.amityFollowRelationshipComposerUsecase});

  @override
  Future<PageListData<List<AmityFollowRelationship>, String>> get(
      FollowRequest params) async {
    final followings = await followRepo.getMyFollowing(params);
    final followingsComposed = await Stream.fromIterable(followings.data)
        .asyncMap((element) async =>
            await amityFollowRelationshipComposerUsecase.get(element))
        .toList();
    return followings.withItem1(followingsComposed);
  }
}
