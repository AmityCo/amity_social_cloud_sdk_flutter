import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/domain/domain.dart';

class RemoveFollowerUsecase extends UseCase<void, String> {
  final FollowRepo followRepo;
  RemoveFollowerUsecase({required this.followRepo});
  @override
  Future<void> get(String params) {
   return followRepo.unfollow(params);
  }

  @override
  Stream<void> listen(String params) {
    // TODO: implement listen
    throw UnimplementedError();
  }
}
