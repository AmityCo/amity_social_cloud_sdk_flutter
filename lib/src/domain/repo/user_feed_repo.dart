import 'package:amity_sdk/src/core/model/api_request/get_user_feed_request.dart';
import 'package:amity_sdk/src/core/utils/page_list_data.dart';
import 'package:amity_sdk/src/domain/domain.dart';

abstract class UserFeedRepo {
  Future<PageListData<List<AmityPost>, String>> getUserFeed(
      GetUserFeedRequest request);
  Stream<PageListData<List<AmityPost>, String>> getUserFeedStream(
      GetUserFeedRequest request);
}
