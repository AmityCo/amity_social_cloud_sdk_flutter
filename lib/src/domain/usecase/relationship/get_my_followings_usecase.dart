import 'package:amity_sdk/src/core/usercase/usecase.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class GetMyFollowingsUsecase
    extends UseCaseWithoutParam<List<AmityFollowRelationship>> {
  final FollowRepo followRepo;
  final AmityFollowRelationshipComposerUsecase
      amityFollowRelationshipComposerUsecase;
  GetMyFollowingsUsecase(
      {required this.followRepo,
      required this.amityFollowRelationshipComposerUsecase});
  @override
  Future<List<AmityFollowRelationship>> get() async {
    final followings = await followRepo.getMyFollowing();
    return Stream.fromIterable(followings)
        .asyncMap((element) async =>
            await amityFollowRelationshipComposerUsecase.get(element))
        .toList();
  }

  @override
  Stream<List<AmityFollowRelationship>> listen() {
    // TODO: implement listen
    throw UnimplementedError();
  }
}
