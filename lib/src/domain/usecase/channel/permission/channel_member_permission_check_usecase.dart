import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/repo/channel_member_repo.dart';

/// [ChannelMemberPermissionCheckUsecase]
class ChannelMemberPermissionCheckUsecase
    extends SynchronousUseCase<bool, ChannelMemberPermissionCheckRequest> {
  /// Channel Member Repo
  final ChannelMemberRepo channelMemberRepo;

  /// Init [ChannelMemberPermissionCheckUsecase]
  ChannelMemberPermissionCheckUsecase({required this.channelMemberRepo});

  @override
  bool get(ChannelMemberPermissionCheckRequest params) {
    var hasPermission = false;
    try {
      final permissions = channelMemberRepo.getMemberPermission(
          params.channelId, params.userId);
      hasPermission = permissions?.contains(params.permission.value) ?? false;
    } catch (exception) {
      hasPermission = false;
    }
    return hasPermission;
  }
}
