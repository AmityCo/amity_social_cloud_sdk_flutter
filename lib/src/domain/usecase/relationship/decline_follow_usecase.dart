import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class DeclineFollowUsecase extends UseCase<void, String> {
  final FollowRepo followRepo;
  DeclineFollowUsecase({required this.followRepo});
  @override
  Future<void> get(String params) {
    return followRepo.decline(params);
  }

  @override
  Stream<void> listen(String params) {
    // TODO: implement listen
    throw UnimplementedError();
  }
}
