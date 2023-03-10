import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class TopicUnsubscriptionUseCase extends UseCase<void, AmityTopic> {
  final TopicRepository topicRepo;

  TopicUnsubscriptionUseCase({required this.topicRepo});
  @override
  Future<void> get(AmityTopic params) {
    return topicRepo.unsubscribe(params);
  }
}
