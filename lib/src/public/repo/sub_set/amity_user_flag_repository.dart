import 'package:amity_sdk/src/core/service_locator/service_locator.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// Flag Repo for [AmityUser]
class AmityUserFlagRepository {
  /// User Id to flag
  final String userId;

  /// Init Amity User Flag Repo
  AmityUserFlagRepository({required this.userId});

  /* begin_public_function 
  id: user.flag
  */
  Future<AmityUser> flag() {
    return serviceLocator<UserFlagUsecase>().get(userId);
  }
  /* end_public_function */

  /* begin_public_function 
  id: user.unflag
  */
  Future<AmityUser> unflag() {
    return serviceLocator<UserUnflagUsecase>().get(userId);
  }
  /* end_public_function */
}
