import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/domain/domain.dart';

class GetUserFollowingsUsecase
    extends UseCase<List<AmityFollowRelationship>, String> {
  final FollowRepo followRepo;
  final AmityFollowRelationshipComposerUsecase
      amityFollowRelationshipComposerUsecase;
  GetUserFollowingsUsecase(
      {required this.followRepo,
      required this.amityFollowRelationshipComposerUsecase});
  @override
  Future<List<AmityFollowRelationship>> get(String params) async {
    final followings = await followRepo.getFollowing(params);
    return Stream.fromIterable(followings)
        .asyncMap((element) async =>
            await amityFollowRelationshipComposerUsecase.get(element))
        .toList();
  }

  @override
  Stream<List<AmityFollowRelationship>> listen(String params) {
    // TODO: implement listen
    throw UnimplementedError();
  }
}
