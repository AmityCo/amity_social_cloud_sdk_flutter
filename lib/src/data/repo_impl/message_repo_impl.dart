import 'package:amity_sdk/src/core/model/api_request/create_message_request.dart';
import 'package:amity_sdk/src/core/model/api_request/message_query_request.dart';
import 'package:amity_sdk/src/core/utils/page_list_data.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/model/message/amity_message.dart';
import 'package:amity_sdk/src/domain/repo/message_repo.dart';

/// [MessageRepoImpl]
class MessageRepoImpl extends MessageRepo {
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
    final amitMessages = await data.saveToDb<AmityMessage>(dbAdapterRepo);
    return PageListData(amitMessages, data.paging!.next ?? '');
  }

  @override
  Future<AmityMessage> createMessage(CreateMessageRequest request) async {
    final data = await messageApiInterface.createMessage(request);
    final amitMessages = await data.saveToDb<AmityMessage>(dbAdapterRepo);
    return (amitMessages as List).first;
  }
}
