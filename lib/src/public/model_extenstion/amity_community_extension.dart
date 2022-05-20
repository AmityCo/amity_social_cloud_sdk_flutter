import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

extension AmityCommunityExtension on AmityCommunity {
  Future delete({bool hardDelete = false}) {
    return serviceLocator<CommunityDeleteUseCase>().get(communityId!);
  }
}
