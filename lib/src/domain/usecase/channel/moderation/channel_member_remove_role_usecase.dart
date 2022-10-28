import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// [ChannelMemberRemoveRoleUsecase]
class ChannelMemberRemoveRoleUsecase
    extends UseCase<void, UpdateChannelRoleRequest> {
  /// Channel Moderation Repo
  final ChannelModerationRepo channelModerationRepo;

  /// Init [ChannelMemberRemoveRoleUsecase]
  ChannelMemberRemoveRoleUsecase({required this.channelModerationRepo});

  @override
  Future get(UpdateChannelRoleRequest params) async {
    await channelModerationRepo.removeRole(params);
    return;
  }
}
