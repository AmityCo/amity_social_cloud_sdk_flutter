import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// [ChannelMemberAddRoleUsecase]
class ChannelMemberAddRoleUsecase
    extends UseCase<void, UpdateChannelRoleRequest> {
  /// Channel Moderation Repo
  final ChannelModerationRepo channelModerationRepo;

  /// Init [ChannelMemberAddRoleUsecase]
  ChannelMemberAddRoleUsecase({required this.channelModerationRepo});

  @override
  Future get(UpdateChannelRoleRequest params) async {
    await channelModerationRepo.addRole(params);
    return;
  }
}
