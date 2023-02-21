import 'dart:io' if (dart.library.html) 'dart:html';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// [MessageRepoImpl]
class MessageRepoImpl extends MessageRepo {
  /// Message API interface
  final MessageApiInterface messageApiInterface;

  /// Common Db Adapter
  final DbAdapterRepo dbAdapterRepo;

  final FileRepo fileRepo;

  /// init [MessageRepoImpl]
  MessageRepoImpl(
      {required this.messageApiInterface,
      required this.dbAdapterRepo,
      required this.fileRepo});

  @override
  Future<PageListData<List<AmityMessage>, String>> queryMesssage(
      MessageQueryRequest request) async {
    final data = await messageApiInterface.messageQuery(request);
    //mandatory to delete all previous messages, since we don't know
    //the up to date data for each messages
    final isFirstPageRequest = ((request.options?.last ?? 0) > 0) ||
        ((request.options?.before ?? 0) > 0);
    if (request.options?.token == null && isFirstPageRequest) {
      await dbAdapterRepo.messageDbAdapter
          .deleteMessagesByChannelId(request.channelId);
    }
    final amitMessages = await data.saveToDb<AmityMessage>(dbAdapterRepo);
    final String token;
    // if stack from end is true, next page token always the previous one,
    // vice versa with false stack from end
    if (request.stackFromEnd == true) {
      token = data.paging!.previous ?? '';
    } else {
      token = data.paging!.next ?? '';
    }
    return PageListData(amitMessages, token);
  }

  @override
  Stream<List<AmityMessage>> listentMessages(
      RequestBuilder<MessageQueryRequest> request) {
    final req = request.call();
    return dbAdapterRepo.messageDbAdapter
        .listenMessageEntities(request)
        .map((event) {
      final List<AmityMessage> list = [];
      for (var element in event) {
        list.add(element.convertToAmityMessage());
        //sort result
        if (req.stackFromEnd == true) {
          list.sort((a, b) => b.channelSegment!.compareTo(a.channelSegment!));
        } else {
          list.sort((a, b) => a.channelSegment!.compareTo(b.channelSegment!));
        }
      }
      return list;
    });
  }

  @override
  Future<AmityMessage> createMessage(CreateMessageRequest request) async {
    final entity = request.convertToMessageEntity();

    /// Calculate the highest channel segment number for the channel id
    entity.channelSegment = dbAdapterRepo.messageDbAdapter
            .getHighestChannelSagment(request.channelId) +
        1;

    try {
      entity.syncState = AmityMessageSyncState.SYNCING;
      dbAdapterRepo.messageDbAdapter.saveMessageEntity(entity);

      final data = await messageApiInterface.createMessage(request);
      final amitMessages = await data.saveToDb<AmityMessage>(dbAdapterRepo);
      return (amitMessages as List).first;
    } catch (error) {
      entity.syncState = AmityMessageSyncState.FAILED;
      dbAdapterRepo.messageDbAdapter.saveMessageEntity(entity);

      rethrow;
    }
  }

  @override
  Future<AmityMessage> updateMessage(CreateMessageRequest request) async {
    final entity =
        dbAdapterRepo.messageDbAdapter.getMessageEntity(request.messageId!)!;

    try {
      entity.syncState = AmityMessageSyncState.SYNCING;
      dbAdapterRepo.messageDbAdapter.saveMessageEntity(entity);

      final data = await messageApiInterface.updateMessage(request);
      final amitMessages = await data.saveToDb<AmityMessage>(dbAdapterRepo);
      return (amitMessages as List).first;
    } catch (error) {
      entity.syncState = AmityMessageSyncState.FAILED;
      dbAdapterRepo.messageDbAdapter.saveMessageEntity(entity);

      rethrow;
    }
  }

  @override
  bool hasLocalMessage(String messageId) {
    return dbAdapterRepo.messageDbAdapter.getMessageEntity(messageId) != null;
  }

  @override
  Future<AmityMessage> createFileMessage(CreateMessageRequest request) async {
    final entity = request.convertToMessageEntity();

    /// Calculate the highest channel segment number for the channel id
    entity.channelSegment = dbAdapterRepo.messageDbAdapter
            .getHighestChannelSagment(request.channelId) +
        1;

    try {
      // Create file Entity, update it for local preview
      final fileEntity = FileHiveEntity()
        ..fileId = request.messageId
        ..filePath = request.uri!.path
        ..createdAt = DateTime.now();
      dbAdapterRepo.fileDbAdapter.saveFileEntity(fileEntity);
      entity.fileId = request.messageId;

      /// Message Created
      entity.syncState = AmityMessageSyncState.CREATED;
      dbAdapterRepo.messageDbAdapter.saveMessageEntity(entity);

      /// Message media Uploading
      entity.syncState = AmityMessageSyncState.UPLOADING;
      dbAdapterRepo.messageDbAdapter.saveMessageEntity(entity);

      final amityUploadResult = await fileRepo.uploadImage(UploadFileRequest()
        ..files.add(File(request.uri!.path))
        ..uploadId = request.messageId
        ..fullImage = true);

      if (amityUploadResult is AmityUploadComplete) {
        request.fileId = (amityUploadResult as AmityUploadComplete).file.fileId;
      }

      /// Message Syncing
      entity.syncState = AmityMessageSyncState.SYNCING;
      dbAdapterRepo.messageDbAdapter.saveMessageEntity(entity);

      final data = await messageApiInterface.createMessage(request);
      final amitMessages = await data.saveToDb<AmityMessage>(dbAdapterRepo);
      return (amitMessages as List).first;
    } catch (error) {
      entity.syncState = AmityMessageSyncState.FAILED;
      dbAdapterRepo.messageDbAdapter.saveMessageEntity(entity);

      rethrow;
    }
  }

  @override
  AmityMessage? getLocalMessage(String messageId) {
    return dbAdapterRepo.messageDbAdapter
        .getMessageEntity(messageId)
        ?.convertToAmityMessage();
  }

  @override
  Future deleteMessage(String messageId) async {
    await messageApiInterface.deleteMessage(messageId);

    final entity = dbAdapterRepo.messageDbAdapter.getMessageEntity(messageId)!;
    entity.isDeleted = true;
    entity.save();
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

    final amityMessage =
        dbAdapterRepo.messageDbAdapter.getMessageEntity(messageId);

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

    final amityMessage =
        dbAdapterRepo.messageDbAdapter.getMessageEntity(messageId);

    if (amityMessage != null) {
      amityMessage.flaggedByMe = false;
      amityMessage.save();
    }

    return (amitMessages as List).first;
  }
}
