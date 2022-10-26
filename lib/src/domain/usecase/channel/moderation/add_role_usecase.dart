import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// [AddRoleUsecase]
class AddRoleUsecase extends UseCase<void, UpdateChannelRoleRequest> {
  /// Channel Moderation Repo
  final ChannelModerationRepo channelModerationRepo;

  /// Init [AddRoleUsecase]
  AddRoleUsecase({required this.channelModerationRepo});

  @override
  Future get(UpdateChannelRoleRequest params) async {
    await channelModerationRepo.addRole(params);
    return;
  }
}
