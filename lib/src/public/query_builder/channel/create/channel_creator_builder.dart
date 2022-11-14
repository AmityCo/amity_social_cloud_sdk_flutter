import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// [ChannelCreatorBuilder]
class ChannelCreatorBuilder {
  final ChannelCreateUsecase usecase;

  //Optional Params
  String? _channelId;
  final AmityChannelType _type;
  String? _displayName;
  Map<String, dynamic>? _metadata;
  List<String>? _userIds;
  List<String>? _tags;
  String? _avatarFileId;

  /// init [ChannelCreatorBuilder]
  ChannelCreatorBuilder(this.usecase, this._type);

  ChannelCreatorBuilder channelId(String channelId) {
    _channelId = channelId;
    return this;
  }

  ChannelCreatorBuilder displayName(String displayName) {
    _displayName = displayName;
    return this;
  }

  ChannelCreatorBuilder avatar(AmityImage avatar) {
    _avatarFileId = avatar.fileId;
    return this;
  }

  ChannelCreatorBuilder metadata(Map<String, dynamic> metadata) {
    _metadata = metadata;
    return this;
  }

  ChannelCreatorBuilder tags(List<String> tags) {
    _tags = tags;
    return this;
  }

  ChannelCreatorBuilder userIds(List<String> userIds) {
    _userIds = userIds;
    return this;
  }

  Future<AmityChannel> create() async {
    CreateChannelRequest request = CreateChannelRequest();
    request.channelId = _channelId;
    request.type = _type.value;
    request.displayName = _displayName;
    request.userIds = _userIds;
    request.avatarFileId = _avatarFileId;
    request.tags = _tags;
    request.metadata = _metadata;
    return usecase.get(request);
  }
}
