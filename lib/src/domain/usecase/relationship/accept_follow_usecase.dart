import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class AcceptFollowUsecase extends UseCase<void, String> {
  final FollowRepo followRepo;
  AcceptFollowUsecase({required this.followRepo});
  @override
  Future<void> get(String params) {
    return followRepo.accpet(params);
  }

  @override
  Stream<void> listen(String params) {
    throw UnimplementedError();
  }
}
