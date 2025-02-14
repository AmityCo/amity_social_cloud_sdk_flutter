import 'dart:async';

import 'package:amity_sdk/src/core/enum/amity_message_preview_setting.dart';
import 'package:amity_sdk/src/core/enum/events/message_preview_event.dart';
import 'package:amity_sdk/src/core/session/component/session_component.dart';
import 'package:amity_sdk/src/core/session/event_bus/message_preview_event_bus.dart';
import 'package:amity_sdk/src/data/converter/message_preview/message_preview_response_extension_converter.dart';
import 'package:amity_sdk/src/data/data_source/local/hive_entity/message_preview_hive_entity.dart';
import 'package:amity_sdk/src/domain/repo/message_preview_repo.dart';
import 'package:amity_sdk/src/domain/repo/network_settings_repo.dart';
import 'package:amity_sdk/src/domain/repo/sub_channel_repo.dart';
import 'package:amity_sdk/src/src.dart';

class MessagePreviewEngine extends SessionComponent {
  bool _isActive;
  AmityMessagePreviewSetting _messagePreviewSetting =
      AmityMessagePreviewSettingExtension.DEFAULT;
  StreamSubscription? _messagePreviewSubscription;
  StreamSubscription? _chatSettingsSubscription;

  MessagePreviewEngine({
    required super.sessionLifeCycleEventBus,
    required super.sessionStateEventBus,
  }) : _isActive =
            sessionStateEventBus.getCurrentEvent() == SessionState.Established {
    if (_isActive) {
      _fetchChatSettings();
    }

    subscribeToMessagePreviewEvent();
  }

  void subscribeToMessagePreviewEvent() {
    _messagePreviewSubscription =
        MessagePreviewEventBus().observe().listen((event) async {
      await handleMessagePreviewEvent(event);
    });
  }

  Future handleMessagePreviewEvent(MessagePreviewEvent event) async {
    if (event.eventName ==
        MessagePreviewEventName.messagePreviewSettingChange) {
      switch (event.messagePreviewSetting!) {
        case AmityMessagePreviewSetting.NO_MESSAGE_PREVIEW:
          await serviceLocator<MessagePreviewRepo>().clearAllMessagePreviews();
          break;
        case AmityMessagePreviewSetting.MESSAGE_PREVIEW_NOT_INCLUDE_DELETED:
          serviceLocator<MessagePreviewRepo>().clearDeletedMessagePreviews();
          break;
        case AmityMessagePreviewSetting.MESSAGE_PREVIEW_INCLUDE_DELETED:
          break;
      }
    } else if (_isActive &&
        _messagePreviewSetting !=
            AmityMessagePreviewSetting.NO_MESSAGE_PREVIEW) {
      if (event.isEvent(MessagePreviewEventName.messageCreated)) {
        await _handleMessageCreatedEvent(event);
      } else if (event.isEvent(MessagePreviewEventName.messageUpdated)) {
        await _handleMessageUpdated(event);
      } else if (event.isEvent(MessagePreviewEventName.messageDeleted)) {
        await _handleMessageDeleted(event);
      } else if (event.isEvent(MessagePreviewEventName.subChannelUpdated)) {
        await _handleSubChannelUpdated(event);
      } else if (event.isEvent(MessagePreviewEventName.subChannelDeleted)) {
        await _handleSubChannelDeleted(event);
      }
    }
  }

  Future _handleMessageCreatedEvent(MessagePreviewEvent event) async {
    final message = event.message!;
    final subChannel = event.subChannel!;
    MessagePreviewHiveEntity preview =
        message.toMessagePreview().convertToMessagePreviewHiveEntity();
    preview.subChannelName = subChannel.name;
    preview.subChannelUpdatedAt = subChannel.updatedAt;
    return await serviceLocator<MessagePreviewRepo>()
        .saveMessagePreview(preview);
  }

  Future _handleMessageUpdated(MessagePreviewEvent event) async {
    final message = event.message!;
    final preview =
        message.toMessagePreview().convertToMessagePreviewHiveEntity();
    return await serviceLocator<MessagePreviewRepo>()
        .saveMessagePreview(preview);
  }

  Future _handleMessageDeleted(MessagePreviewEvent event) async {
    switch (_messagePreviewSetting) {
      case AmityMessagePreviewSetting.MESSAGE_PREVIEW_INCLUDE_DELETED:
        await _handleMessageUpdated(MessagePreviewEvent.messageUpdated(
            event.message!, event.subChannel!));
        break;
      case AmityMessagePreviewSetting.MESSAGE_PREVIEW_NOT_INCLUDE_DELETED:
        await _fetchSubChannelIfNeeded(event);
        break;
      case AmityMessagePreviewSetting.NO_MESSAGE_PREVIEW:
        break;
    }
  }

  Future _handleSubChannelUpdated(MessagePreviewEvent event) async {
    final messagePreviewRepository = serviceLocator<MessagePreviewRepo>();
    if (event.subChannel!.subChannelId == null) return;

    final cache = await messagePreviewRepository
        .getMessagePreviewBySubChannelId(event.subChannel!.subChannelId!);

    if (cache == null || event.subChannel?.updatedAt == null) return;

    if (cache.subChannelUpdatedAt?.isBefore(event.subChannel!.updatedAt!) ==
            true &&
        event.subChannel!.name != null) {
      await messagePreviewRepository.updateSubChannelInfo(
          event.subChannel!.subChannelId!,
          event.subChannel!.name!,
          event.subChannel!.updatedAt!);
    }
  }

  Future _handleSubChannelDeleted(MessagePreviewEvent event) async {
    if ((_messagePreviewSetting ==
                AmityMessagePreviewSetting
                    .MESSAGE_PREVIEW_NOT_INCLUDE_DELETED ||
            _messagePreviewSetting ==
                AmityMessagePreviewSetting.MESSAGE_PREVIEW_INCLUDE_DELETED) &&
        event.subChannel?.channelPublicId != null) {
      final channelCache = await serviceLocator<MessagePreviewRepo>()
          .getMessagePreviewByChannelId(event.subChannel!.channelPublicId!);

      if (channelCache?.subChannelId == event.subChannel?.subChannelId &&
          event.subChannel?.channelPublicId != null) {
        final channelId = event.subChannel!.channelPublicId;
        await serviceLocator<ChannelRepo>().getChannel(channelId!);
      }
    }
  }

  Future _fetchSubChannelIfNeeded(MessagePreviewEvent event) async {
    final messagePreviewRepository = serviceLocator<MessagePreviewRepo>();
    final cache = await messagePreviewRepository
        .getMessagePreview(event.message!.messageId);

    if (cache != null) {
      final channelCache = await messagePreviewRepository
          .getMessagePreviewByChannelId(event.message!.channelId);

      await messagePreviewRepository
          .deleteMessagePreview(event.message!.messageId);

      try {
        final subChannelId = event.message!.subChannelId;
        serviceLocator<SubChannelRepo>().fetchAndSave(subChannelId!);

        if (channelCache?.messagePreviewId == event.message!.messageId) {
          serviceLocator<ChannelRepo>().getChannel(event.message!.channelId);
        }
      } catch (e) {
        // Handle or log error
      }
    }
  }

  void _fetchChatSettings() {
    serviceLocator<NetworkSettingsRepo>().fetchChatSettings().then((value) {
      final settings = value.messagePreviewSetting;
      _messagePreviewSetting = settings;
    });
    serviceLocator<NetworkSettingsRepo>().observeChatSettings().listen((event) {
      _messagePreviewSetting = event.messagePreviewSetting;
    });
  }

  @override
  void onSessionStateChange(SessionState sessionState) {
    switch (sessionState) {
      case SessionState.Established:
        _isActive = true;
        _fetchChatSettings();
        break;
      default:
        _isActive = false;
    }
  }

  @override
  void establish() {
    if (_messagePreviewSubscription == null) {
      subscribeToMessagePreviewEvent();
    }
    _isActive = true;
    _fetchChatSettings();
  }

  @override
  void destroy() {
    _isActive = false;
    _messagePreviewSubscription?.cancel();
    _messagePreviewSubscription = null;
    _chatSettingsSubscription?.cancel();
    _chatSettingsSubscription = null;
  }

  @override
  void handleTokenExpire() {
    _isActive = false;
  }
}
