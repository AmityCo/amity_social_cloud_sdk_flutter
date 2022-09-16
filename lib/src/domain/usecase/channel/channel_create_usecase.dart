import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// [ChannelCreateUsecase]
class ChannelCreateUsecase extends UseCase<AmityChannel, CreateChannelRequest> {
  /// Channel Repo
  final ChannelRepo channelRepo;

  /// Channel Composer Usecase
  final ChannelComposerUsecase channelComposerUsecase;

  /// Init [ChannelCreateUsecase]
  ChannelCreateUsecase(
      {required this.channelRepo, required this.channelComposerUsecase});

  @override
  Future<AmityChannel> get(CreateChannelRequest params) async {
    final amityChannel = await channelRepo.createChannel(params);
    final amityCreatedChannel = await channelComposerUsecase.get(amityChannel);
    return amityCreatedChannel;
  }

  @override
  Stream<AmityChannel> listen(CreateChannelRequest params) {
    // TODO: implement listen
    throw UnimplementedError();
  }
}
