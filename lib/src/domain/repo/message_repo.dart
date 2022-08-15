import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/model/message/amity_message.dart';

abstract class MessageRepo {
  Future<PageListData<List<AmityMessage>, String>> queryMesssage(
      MessageQueryRequest request);
}
