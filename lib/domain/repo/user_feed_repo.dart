import 'package:amity_sdk/core/model/api_request/get_user_feed_request.dart';
import 'package:amity_sdk/core/utils/tuple.dart';
import 'package:amity_sdk/domain/domain.dart';

abstract class UserFeedRepo {
  Future<Tuple2<List<AmityPost>, String>> getUserFeed(
      GetUserFeedRequest request);
  Stream<Tuple2<List<AmityPost>, String>> getUserFeedStream(
      GetUserFeedRequest request);
}
