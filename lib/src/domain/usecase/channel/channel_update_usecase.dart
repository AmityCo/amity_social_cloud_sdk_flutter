import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// [ChannelGetQueryUseCase]
class ChannelUpdateUseCase extends UseCase<AmityChannel, CreateChannelRequest> {
  /// Channel Repo
  final ChannelRepo channelRepo;

  /// Channel Composer Usecase
  final ChannelComposerUsecase channelComposerUsecase;

  /// Init [ChannelGetQueryUseCase]
  ChannelUpdateUseCase(
      {required this.channelRepo, required this.channelComposerUsecase});
  @override
  Future<AmityChannel> get(CreateChannelRequest params) async {
    final amityChannel = await channelRepo.updateChannel(params);
    final amityChannelComposed = await channelComposerUsecase.get(amityChannel);
    return amityChannelComposed;
  }
}
