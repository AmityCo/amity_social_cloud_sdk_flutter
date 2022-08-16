import 'package:amity_sdk/src/core/utils/live_collection.dart';
import 'package:amity_sdk/src/domain/model/message/amity_message.dart';
import 'package:amity_sdk/src/domain/usecase/message/message_observe_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/message/message_query_use_case.dart';
import 'package:amity_sdk/src/src.dart';

class MessageLiveCollection extends LiveCollection<AmityMessage> {
  MessageQueryRequest params;
  MessageLiveCollection({required this.params});

  @override
  Future<PageListData<List<AmityMessage>, String>> getFirstPageRequest() async {
    params.options?.token = null;
    params.options?.limit = 20;
    final result = await serviceLocator<MessageQueryUseCase>().get(params);
    currentToken = result.token;
    return result;
  }

  @override
  Future<PageListData<List<AmityMessage>, String>> getNextPageRequest(
      String? token) async {
    params.options?.token = token;
    params.options?.limit = null;
    final result = await serviceLocator<MessageQueryUseCase>().get(params);
    currentToken = result.token;
    return result;
  }

  @override
  Stream<List<AmityMessage>> asStream() {
    return serviceLocator<MessageObserveUsecase>().listen(params);
  }
}
