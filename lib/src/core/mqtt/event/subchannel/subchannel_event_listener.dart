import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/converter/sub_channel/create_sub_channel_response_extension.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/usecase/subchannel/sub_channel_has_local_usecase.dart';

abstract class SubChannelEventListener extends MQTTEventListener {
  @override
  void processEvent(Map<String, dynamic> json) {
    final data = CreateSubChannelResponse.fromJson(json);

    data.saveToDb(serviceLocator());
  }

  @override
  bool shouldProcessEvent(Map<String, dynamic> json) {
    final data = CreateSubChannelResponse.fromJson(json);
    if (data.subChannels.isNotEmpty) {
      return _hasLocalStory(data.subChannels[0].subChannelId!);
    } else {
      return false;
    }
  }

  bool _hasLocalStory(String storyId) {
    return serviceLocator<SubChannelHasLocalUseCase>().get(storyId);
  }
}
