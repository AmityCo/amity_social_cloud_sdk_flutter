import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// [ChannelMemberComposerUsecase]
class ChannelMemberComposerUsecase
    extends UseCase<AmityChannelMember, AmityChannelMember> {
  final UserRepo userRepo;
  final UserComposerUsecase userComposerUsecase;

  /// Init [ChannelMemberComposerUsecase]
  ChannelMemberComposerUsecase(
      {required this.userRepo, required this.userComposerUsecase});

  @override
  Future<AmityChannelMember> get(AmityChannelMember params) async {
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
