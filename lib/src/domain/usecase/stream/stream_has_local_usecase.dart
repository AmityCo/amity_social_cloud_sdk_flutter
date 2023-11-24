import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class StreamHasLocalUseCase extends SynchronousUseCase<bool, String> {
  final StreamRepo streamRepo;

  StreamHasLocalUseCase( {required this.streamRepo});

  @override
  bool get(String params) {
    return streamRepo.hasLocal(params);
  }
}