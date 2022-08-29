import 'package:amity_sdk/src/core/enum/amity_message_sync_state.dart';
import 'package:amity_sdk/src/core/model/api_request/create_message_request.dart';
import 'package:amity_sdk/src/core/model/api_request/message_query_request.dart';
import 'package:amity_sdk/src/core/utils/page_list_data.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/model/message/amity_message.dart';
import 'package:amity_sdk/src/domain/repo/message_repo.dart';

/// [MessageRepoImpl]
class MessageRepoImpl extends MessageRepo {
  /// Message API interface
  final MessageApiInterface messageApiInterface;

  /// Common Db Adapter
  final DbAdapterRepo dbAdapterRepo;

  /// init [MessageRepoImpl]
  MessageRepoImpl(
      {required this.messageApiInterface, required this.dbAdapterRepo});

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
  Stream<List<AmityMessage>> listentMessages(MessageQueryRequest request) {
    return dbAdapterRepo.messageDbAdapter
        .listenMessageEntities(request)
        .map((event) {
      final List<AmityMessage> list = [];
      for (var element in event) {
        list.add(element.convertToAmityMessage());
        //sort result
        if (request.stackFromEnd == true) {
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
  bool hasLocalMessage(String messageId) {
    return dbAdapterRepo.messageDbAdapter.getMessageEntity(messageId) != null;
  }
}
