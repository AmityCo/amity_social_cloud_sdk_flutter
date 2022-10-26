import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// [ChannelDeleteUseCase]
class ChannelDeleteUseCase extends UseCase<void, String> {
  /// Channel Repo
  final ChannelRepo channelRepo;

  /// init [ChannelDeleteUseCase]
  ChannelDeleteUseCase({required this.channelRepo});
  @override
  Future get(String params) {
    return channelRepo.deleteChannel(params);
  }
}
