import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/model/api_request/get_reach_user_request.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/domain/repo/analytics_repo.dart';

class GetReachUserUseCase extends UseCase<PageListData<List<AmityUser>, String>,
    GetReachUserRequest> {
  final UserComposerUsecase userComposerUsecase;
  final AnalyticsRepo analyticsRepo;

  GetReachUserUseCase(
      {required this.userComposerUsecase, required this.analyticsRepo});

  @override
  Future<PageListData<List<AmityUser>, String>> get(
      GetReachUserRequest params) async {
    final amityUsers = await analyticsRepo.getViewedUsers(params);
    final amityComposedUsers = await Stream.fromIterable(amityUsers.data)
        .asyncMap((event) async => await userComposerUsecase.get(event))
        .toList();
    return amityUsers.withItem1(amityComposedUsers);
  }
}
