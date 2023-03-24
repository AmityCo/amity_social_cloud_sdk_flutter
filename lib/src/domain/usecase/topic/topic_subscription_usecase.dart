import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class TopicSubscriptionUseCase extends UseCase<dynamic, AmityTopic> {
  final TopicRepository topicRepo;

  TopicSubscriptionUseCase({required this.topicRepo});
  @override
  Future get(AmityTopic params) {
    return topicRepo.subscribe(params);
  }
}
