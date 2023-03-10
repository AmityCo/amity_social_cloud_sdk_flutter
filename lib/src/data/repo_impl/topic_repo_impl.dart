import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/repo/topic_repo.dart';

class TopicRepositoryImpl extends TopicRepository {
  AmityMQTT amityMqtt;
  TopicRepositoryImpl({
    required this.amityMqtt,
  });

  @override
  Future subscribe(AmityTopic topic) async {
    amityMqtt.subscribe(topic);
  }

  @override
  Future unsubscribe(AmityTopic topic) async {
    amityMqtt.unsubscribe(topic);
  }
}
