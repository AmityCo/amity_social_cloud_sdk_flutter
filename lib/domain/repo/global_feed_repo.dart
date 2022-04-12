import 'package:amity_sdk/core/model/api_request/get_global_feed_request.dart';
import 'package:amity_sdk/core/utils/tuple.dart';
import 'package:amity_sdk/domain/model/amity_post.dart';

abstract class GlobalFeedRepo {
  Future<Tuple2<List<AmityPost>, String>> getGlobalFeed(
      GetGlobalFeedRequest request);
  Stream<Tuple2<List<AmityPost>, String>> getGlobalFeedStream(
      GetGlobalFeedRequest request);
}
