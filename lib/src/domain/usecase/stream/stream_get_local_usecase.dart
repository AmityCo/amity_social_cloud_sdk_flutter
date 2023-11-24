import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class StreamGetLocalUseCase extends  SynchronousUseCase<AmityStream, String> {

final StreamRepo streamRepo;
StreamGetLocalUseCase({required this.streamRepo});

  @override
  AmityStream get(String params) {
    return streamRepo.getLocal(params);
  }

}