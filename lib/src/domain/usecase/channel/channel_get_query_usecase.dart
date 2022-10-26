import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// [ChannelGetQueryUseCase]
class ChannelGetQueryUseCase extends UseCase<
    PageListData<List<AmityChannel>, String>, GetChannelRequest> {
  /// Channel Repo
  final ChannelRepo channelRepo;

  /// Channel Composer Usecase
  final ChannelComposerUsecase channelComposerUsecase;

  /// init [ChannelGetQueryUseCase]
  ChannelGetQueryUseCase(
      {required this.channelRepo, required this.channelComposerUsecase});
  @override
  Future<PageListData<List<AmityChannel>, String>> get(
      GetChannelRequest params) async {
    final amityCommunities = await channelRepo.getChannelQuery(params);
    final amityComposedChannel =
        await Stream.fromIterable(amityCommunities.data)
            .asyncMap<AmityChannel>(
                (event) async => await channelComposerUsecase.get(event))
            .toList();
    return amityCommunities.withItem1(amityComposedChannel);
  }
}
