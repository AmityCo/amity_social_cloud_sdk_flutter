import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/domain.dart';

///[CommunityMemberEventListener]
abstract class CommunityMemberEventListener extends SocketEventListener {
  @override
  void processEvent(Map<String, dynamic> json) {
    final data = GetCommunityMembersResponse.fromJson(json);

    data.saveToDb(serviceLocator());
  }

  /// This method is used to check if the event should be processed or not.
  @override
  bool shouldProcessEvent(Map<String, dynamic> json) {
    final data = GetCommunityMembersResponse.fromJson(json);
    if (data.communities.isNotEmpty) {
      return _hasLocalCommunityMember(
          data.communityUsers[0].communityId, data.communityUsers[0].userId);
    } else {
      return false;
    }
  }

  bool _hasLocalCommunityMember(String communityId, String userId) {
    return serviceLocator<CommunityMemberHasLocalUsecase>().get(
        CommunityMemberPermissionCheckRequest(
            communityId: communityId, userId: userId));
  }
}
