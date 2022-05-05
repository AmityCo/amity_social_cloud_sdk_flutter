import 'package:amity_sdk/src/core/model/api_request/get_user_feed_request.dart';
import 'package:amity_sdk/src/core/utils/tuple.dart';
import 'package:amity_sdk/src/domain/domain.dart';

abstract class UserFeedRepo {
  Future<Tuple2<List<AmityPost>, String>> getUserFeed(
      GetUserFeedRequest request);
  Stream<Tuple2<List<AmityPost>, String>> getUserFeedStream(
      GetUserFeedRequest request);
}
