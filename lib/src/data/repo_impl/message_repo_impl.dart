import 'dart:io' if (dart.library.html) 'dart:html';
import 'dart:math';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/enum/events/message_preview_event.dart';
import 'package:amity_sdk/src/core/session/event_bus/message_preview_event_bus.dart';
import 'package:amity_sdk/src/core/utils/amity_nonce.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/data/response/core_response/sub_channel_response.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/domain/repo/paging_id_repo.dart';
import 'package:amity_sdk/src/domain/usecase/channel/channel_update_last_activity_usecase.dart';
import 'package:collection/collection.dart';

/// [MessageRepoImpl]
class MessageRepoImpl extends MessageRepo {
  /// Message API interface
  final MessageApiInterface messageApiInterface;

  /// Common Db Adapter
  final DbAdapterRepo dbAdapterRepo;

  final FileRepo fileRepo;

  final ChannelRepo channelRepo;

  final PagingIdRepo pagingIdRepo;

  /// init [MessageRepoImpl]
  MessageRepoImpl({required this.messageApiInterface, required this.dbAdapterRepo, required this.fileRepo, required this.channelRepo, required this.pagingIdRepo});

  @override
  Future<PageListData<List<AmityMessage>, String>> queryMesssage(MessageQueryRequest request) async {
    final hash = request.getHashCode();
    final nonce = request.getNonce();
    int nextIndex = 0;
    final data = await messageApiInterface.messageQuery(request);
    final paging = data.paging;
    final amitMessages = await data.saveToDb<AmityMessage>(dbAdapterRepo);
    //mandatory to delete all previous messages, since we don't know
    //the up to date data for each messages
    final isFirstPage = request.options?.token == null && (request.options?.limit ?? 0) > 0;
    if (isFirstPage) {
      await pagingIdRepo.deletePagingIdByHash(nonce.value, hash);
    } else {
      nextIndex = (pagingIdRepo.getPagingIdEntities(nonce.value, hash).map((e) => (e.position ?? 0)).toList().reduce(max)) + 1;
    }
    data.messages.forEachIndexed((index, element) async {
      final pagingId = PagingIdHiveEntity(
        id: element.referenceId ?? element.messageId,
        hash: hash,
        nonce: nonce.value,
        position: nextIndex + index,
      );
      await pagingIdRepo.savePagingId(pagingId);
    });
    return PageListData(amitMessages, paging?.next ?? '');
  }

  @override
  Stream<List<AmityMessage>> listenMessages(RequestBuilder<MessageQueryRequest> request) {
    final req = request.call();
    return dbAdapterRepo.messageDbAdapter.listenMessageEntities(request).map((event) {
      final List<AmityMessage> list = [];
      for (var element in event) {
        list.add(element.convertToAmityMessage());
      }
      return list;
    });
  }

  @override
  List<MessageHiveEntity> getMessageEntities(
      RequestBuilder<MessageQueryRequest> request) {
    return dbAdapterRepo.messageDbAdapter.getMessageEntities(request);
  }

  @override
  Future<AmityMessage> createMessage(CreateMessageRequest request) async {
    final entity = request.convertToMessageEntity();

    /// Calculate the highest channel segment number for the channel id
    entity.channelSegment = dbAdapterRepo.messageDbAdapter.getHighestChannelSagment(request.subchannelId) + 1;

    try {
      entity.syncState = AmityMessageSyncState.SYNCING.value;
      dbAdapterRepo.messageDbAdapter.saveMessageEntity(entity);

      final data = await messageApiInterface.createMessage(request);
      final amitMessages = await data.saveToDb<AmityMessage>(dbAdapterRepo);
      await ChannelUpdateLastActivityUsecase(channelRepo: channelRepo).process(request.subchannelId);
      _publishMessagePreviewEvent(data, MessagePreviewEventName.messageCreated);
      return (amitMessages as List).first;
    } catch (error) {
      entity.syncState = AmityMessageSyncState.FAILED.value;
      dbAdapterRepo.messageDbAdapter.saveMessageEntity(entity);

      rethrow;
    }
  }

  void _publishMessagePreviewEvent(CreateMessageResponse data, MessagePreviewEventName eventName) {
    for (var message in data.messages) {
      final subChannel = data.subChannels.cast<SubChannelResponse?>().firstWhere((subChannel) => subChannel?.subChannelId == message.subChannelId, orElse: () => null);
      if (subChannel != null) {
        if (eventName == MessagePreviewEventName.messageCreated) {
          MessagePreviewEventBus().publish(MessagePreviewEvent.messageCreated(message, subChannel));
        } else if (eventName == MessagePreviewEventName.messageUpdated) {
          MessagePreviewEventBus().publish(MessagePreviewEvent.messageUpdated(message, subChannel));
        } else if (eventName == MessagePreviewEventName.messageDeleted) {
          MessagePreviewEventBus().publish(MessagePreviewEvent.messageDeleted(message, subChannel));
        }
      }
    }
  }

  @override
  Future<AmityMessage> updateMessage(CreateMessageRequest request) async {
    try {
      final data = await messageApiInterface.updateMessage(request);
      final amitMessages = await data.saveToDb<AmityMessage>(dbAdapterRepo);
      _publishMessagePreviewEvent(data, MessagePreviewEventName.messageUpdated);
      return (amitMessages as List).first;
    } catch (error) {

      rethrow;
    }
  }

  @override
  bool hasLocalMessage(String uniqueId) {
    return dbAdapterRepo.messageDbAdapter.getMessageEntity(uniqueId) != null;
  }

  @override
  Future<AmityMessage> createFileMessage(CreateMessageRequest request) async {
    final entity = request.convertToMessageEntity();

    /// Calculate the highest channel segment number for the channel id
    entity.channelSegment = dbAdapterRepo.messageDbAdapter.getHighestChannelSagment(request.subchannelId) + 1;

    try {
      // Create file Entity, update it for local preview
      final fileEntity = FileHiveEntity()
        ..fileId = request.messageId
        ..filePath = request.uri!.path
        ..createdAt = DateTime.now();
      dbAdapterRepo.fileDbAdapter.saveFileEntity(fileEntity);
      entity.fileId = request.messageId;

      /// Message Created
      entity.syncState = AmityMessageSyncState.CREATED.value;
      await dbAdapterRepo.messageDbAdapter.saveMessageEntity(entity);

      /// Message media Uploading
      entity.syncState = AmityMessageSyncState.UPLOADING.value;
      await dbAdapterRepo.messageDbAdapter.saveMessageEntity(entity);

      var amityUploadResult;
      if (request.type == AmityMessageDataType.IMAGE.value) {
          amityUploadResult = await fileRepo.uploadImageStream(UploadFileRequest(files: [File(request.uri!.path)])
            ..uploadId = request.messageId
            ..fullImage = true)
            .stream
            .firstWhere((element) => 
              element is AmityUploadComplete
              || element is AmityUploadError
              || element is AmityUploadCancel);
      } else if (request.type == AmityMessageDataType.VIDEO.value) {
        amityUploadResult = await fileRepo.uploadVideoStream(UploadFileRequest(files: [File(request.uri!.path)], feedtype: AmityContentFeedType.MESSAGE.value)
            ..uploadId = request.messageId
            ..fullImage = true)
            .stream
            .firstWhere((element) => 
              element is AmityUploadComplete
              || element is AmityUploadError
              || element is AmityUploadCancel);
      } else {
          amityUploadResult = await fileRepo
              .uploadFileStream(UploadFileRequest(files: [File(request.uri!.path)])..uploadId = request.messageId)
              .stream
              .firstWhere((element) => 
                element is AmityUploadComplete
                || element is AmityUploadError
                || element is AmityUploadCancel);
      }

      if (amityUploadResult is AmityUploadComplete) {
        request.fileId = (amityUploadResult as AmityUploadComplete).file.fileId;
      }

      /// Message Syncing
      entity.syncState = AmityMessageSyncState.SYNCING.value;
      await dbAdapterRepo.messageDbAdapter.saveMessageEntity(entity);

      final data = await messageApiInterface.createMessage(request);
      final amitMessages = await data.saveToDb<AmityMessage>(dbAdapterRepo);
      await ChannelUpdateLastActivityUsecase(channelRepo: channelRepo).process(request.subchannelId);
      return (amitMessages as List).first;

    } catch (error) {
      entity.syncState = AmityMessageSyncState.FAILED.value;
      dbAdapterRepo.messageDbAdapter.saveMessageEntity(entity);

      rethrow;
    }
  }

  @override
  AmityMessage? getLocalMessage(String messageId) {
    return dbAdapterRepo.messageDbAdapter.getMessageEntity(messageId)?.convertToAmityMessage();
  }

  @override
  Future deleteMessage(String uniqueId) async {
    final entity = dbAdapterRepo.messageDbAdapter.getMessageEntity(uniqueId);
    if (entity != null) {
      final messageId = entity.messageId;
      if (entity.syncState == AmityMessageSyncState.SYNCED.value && messageId != null) {
        try { 
          final data = await messageApiInterface.deleteMessage(messageId!);
          entity.isDeleted = true;
          entity.save();
          _publishMessagePreviewEvent(data, MessagePreviewEventName.messageDeleted);
        } catch (error) {
          return Future.error(error);
        }
      } else {
        await dbAdapterRepo.messageDbAdapter.deleteMessageEntity(entity);
      }
    }
  }

  @override
  Future<AmityMessage> getMessage(String messageId) async {
    final data = await messageApiInterface.getMessage(messageId);
    final amitMessages = await data.saveToDb<AmityMessage>(dbAdapterRepo);
    return (amitMessages as List).first;
  }

  @override
  Future<AmityMessage> flagMessage(String messageId) async {
    final data = await messageApiInterface.flagMessage(messageId);
    final amitMessages = await data.saveToDb<AmityMessage>(dbAdapterRepo);

    final amityMessage = dbAdapterRepo.messageDbAdapter.getMessageEntity(messageId);

    if (amityMessage != null) {
      amityMessage.flaggedByMe = true;
      amityMessage.save();
    }

    return (amitMessages as List).first;
  }

  @override
  Future<AmityMessage> unFlagMessage(String messageId) async {
    final data = await messageApiInterface.unFlagMessage(messageId);
    final amitMessages = await data.saveToDb<AmityMessage>(dbAdapterRepo);

    final amityMessage = dbAdapterRepo.messageDbAdapter.getMessageEntity(messageId);

    if (amityMessage != null) {
      amityMessage.flaggedByMe = false;
      amityMessage.save();
    }

    return (amitMessages as List).first;
  }
}
