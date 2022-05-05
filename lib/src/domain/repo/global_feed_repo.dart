import 'package:amity_sdk/src/core/model/api_request/get_global_feed_request.dart';
import 'package:amity_sdk/src/core/utils/tuple.dart';
import 'package:amity_sdk/src/domain/model/amity_post.dart';

abstract class GlobalFeedRepo {
  Future<Tuple2<List<AmityPost>, String>> getGlobalFeed(
      GetGlobalFeedRequest request);
  Stream<Tuple2<List<AmityPost>, String>> getGlobalFeedStream(
      GetGlobalFeedRequest request);
}
