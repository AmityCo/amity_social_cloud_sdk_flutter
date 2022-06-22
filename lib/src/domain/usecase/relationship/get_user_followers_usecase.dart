import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class GetUserFollowersUsecase extends UseCase<
    Tuple2<List<AmityFollowRelationship>, String>, FollowRequest> {
  final FollowRepo followRepo;
  final AmityFollowRelationshipComposerUsecase
      amityFollowRelationshipComposerUsecase;
  GetUserFollowersUsecase(
      {required this.followRepo,
      required this.amityFollowRelationshipComposerUsecase});

  @override
  Future<Tuple2<List<AmityFollowRelationship>, String>> get(
      FollowRequest params) async {
    final followers = await followRepo.getFollower(params);
    final followersComposed = await Stream.fromIterable(followers.item1)
        .asyncMap((element) async =>
            await amityFollowRelationshipComposerUsecase.get(element))
        .toList();
    return followers.withItem1(followersComposed);
  }

  @override
  Stream<Tuple2<List<AmityFollowRelationship>, String>> listen(
      FollowRequest params) {
    throw UnimplementedError();
  }
}
