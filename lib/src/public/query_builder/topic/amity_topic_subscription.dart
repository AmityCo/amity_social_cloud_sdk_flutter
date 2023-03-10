import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class AmityTopicSubscription {
  final AmityTopic topic;

  AmityTopicSubscription(this.topic);

  Future subscribeTopic() {
    return serviceLocator<TopicSubscriptionUseCase>().get(topic);
  }

  Future unsubscribeTopic() {
    return serviceLocator<TopicUnsubscriptionUseCase>().get(topic);
  }
}
