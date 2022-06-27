import 'package:amity_sdk/src/core/model/api_request/get_global_feed_request.dart';
import 'package:amity_sdk/src/core/utils/page_list_data.dart';
import 'package:amity_sdk/src/domain/model/amity_post.dart';

abstract class GlobalFeedRepo {
  Future<PageListData<List<AmityPost>, String>> getGlobalFeed(
      GetGlobalFeedRequest request);
  Stream<PageListData<List<AmityPost>, String>> getGlobalFeedStream(
      GetGlobalFeedRequest request);
}
