import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class GetMyFollowersUsecase
    extends UseCaseWithoutParam<List<AmityFollowRelationship>> {
  final FollowRepo followRepo;
  final AmityFollowRelationshipComposerUsecase
      amityFollowRelationshipComposerUsecase;
  GetMyFollowersUsecase(
      {required this.followRepo,
      required this.amityFollowRelationshipComposerUsecase});

  @override
  Future<List<AmityFollowRelationship>> get() async {
    final followers = await followRepo.getMyFollower();
    return Stream.fromIterable(followers)
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
