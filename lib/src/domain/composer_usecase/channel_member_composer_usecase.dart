import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// [ChannelMemberComposerUsecase]
class ChannelMemberComposerUsecase
    extends UseCase<AmityChannelMember, AmityChannelMember> {
  /// Channel Repo
  final ChannelRepo channelRepo;

  /// User Repo
  final UserRepo userRepo;

  /// User Composer Usecase
  final UserComposerUsecase userComposerUsecase;

  /// Init [ChannelMemberComposerUsecase]
  ChannelMemberComposerUsecase(
      {required this.channelRepo,
      required this.userRepo,
      required this.userComposerUsecase});

  @override
  Future<AmityChannelMember> get(AmityChannelMember params) async {
    final channel = await channelRepo.getChannelById(params.channelId!);
    params.displayName = channel.displayName;

    final rawUser = await userRepo.getUserByIdFromDb(params.userId!);
    params.user = await userComposerUsecase.get(rawUser);
    return params;
  }

  @override
  Stream<AmityChannelMember> listen(AmityChannelMember params) {
    // TODO: implement listen
    throw UnimplementedError();
  }
}
