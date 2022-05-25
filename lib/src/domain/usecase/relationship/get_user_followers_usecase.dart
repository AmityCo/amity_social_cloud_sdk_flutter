import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class GetUserFollowersUsecase
    extends UseCase<List<AmityFollowRelationship>, String> {
  final FollowRepo followRepo;
  final AmityFollowRelationshipComposerUsecase
      amityFollowRelationshipComposerUsecase;
  GetUserFollowersUsecase(
      {required this.followRepo,
      required this.amityFollowRelationshipComposerUsecase});
  @override
  Future<List<AmityFollowRelationship>> get(String params) async {
    final followers = await followRepo.getFollower(params);
    return Stream.fromIterable(followers)
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
