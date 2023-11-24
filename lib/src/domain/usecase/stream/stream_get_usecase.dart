import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/composer_usecase/stream_composer_usecase.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class StreamGetUseCase extends UseCase<AmityStream, String>{
  

  final StreamRepo streamRepo;
  final StreamComposerUseCase streamComposerUseCase;
  
  StreamGetUseCase({required this.streamRepo , required this.streamComposerUseCase});
  
  
  @override
  Future<AmityStream> get(String params) async {
    final amityStream = await streamRepo.getStream(params);
    final amityComposedStream = await streamComposerUseCase.get(amityStream);
    return amityComposedStream;
  }

}