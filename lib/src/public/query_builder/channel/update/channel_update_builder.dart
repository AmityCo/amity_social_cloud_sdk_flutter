import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// [ChannelUpdateBuilder]
class ChannelUpdateBuilder {
  final ChannelUpdateUseCase usecase;
  final String _channelId;
  //Optional Params
  String? _displayName;
  Map<String, dynamic>? _metadata;
  List<String>? _tags;
  String? _avatarFileId;

  /// init [ChannelUpdateBuilder]
  ChannelUpdateBuilder(this._channelId, this.usecase);

  ChannelUpdateBuilder displayName(String displayName) {
    _displayName = displayName;
    return this;
  }

  ChannelUpdateBuilder avatar(AmityImage avatar) {
    _avatarFileId = avatar.fileId;
    return this;
  }

  ChannelUpdateBuilder metadata(Map<String, dynamic> metadata) {
    _metadata = metadata;
    return this;
  }

  ChannelUpdateBuilder tags(List<String> tags) {
    _tags = tags;
    return this;
  }

  Future<AmityChannel> create() async {
    CreateChannelRequest request = CreateChannelRequest();
    request.channelId = _channelId;
    request.displayName = _displayName;
    request.avatarFileId = _avatarFileId;
    request.tags = _tags;
    request.metadata = _metadata;
    return usecase.get(request);
  }
}
