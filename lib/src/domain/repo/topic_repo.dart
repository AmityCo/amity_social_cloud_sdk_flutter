import 'package:amity_sdk/src/core/core.dart';

abstract class TopicRepository {
  Future subscribe(AmityTopic topic);
  Future unsubscribe(AmityTopic topic);
}
