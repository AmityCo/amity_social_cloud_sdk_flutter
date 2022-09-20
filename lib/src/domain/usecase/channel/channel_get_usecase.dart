import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// [ChannelGetUseCase]
class ChannelGetUseCase extends UseCase<AmityChannel, String> {
  /// Channel Repo
  final ChannelRepo channelRepo;

  /// Channel Composer Usecase
  final ChannelComposerUsecase channelComposerUsecase;

  /// Init [ChannelGetUseCase]
  ChannelGetUseCase(
      {required this.channelRepo, required this.channelComposerUsecase});
  @override
  Future<AmityChannel> get(String params) async {
    final amityChannel = await channelRepo.getChannel(params);
    final amityChannelComposed = await channelComposerUsecase.get(amityChannel);
    return amityChannelComposed;
  }
}
