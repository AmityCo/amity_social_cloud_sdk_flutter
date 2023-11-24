import 'dart:async';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/model/api_request/stream_query_request.dart';
import 'package:amity_sdk/src/domain/composer_usecase/stream_composer_usecase.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class StreamObserveUseCase extends UseCase<List<AmityStream> , StreamQueryRequest>{

  final StreamRepo streamRepo;
  final StreamComposerUseCase streamComposerUseCase;

  StreamObserveUseCase({required this.streamRepo , required this.streamComposerUseCase});


  @override
  Future<List<AmityStream>> get(StreamQueryRequest params) {
     throw UnimplementedError();
  }
  
  /// Listen Stream Query Request
  StreamController<List<AmityStream>> listen(
      RequestBuilder<StreamQueryRequest> request) {
    final streamController = StreamController<List<AmityStream>>();

    streamRepo.listenStreams(request).listen((event) async {
      await Stream.fromIterable(event).forEach((element) async {
        element = await streamComposerUseCase.get(element);
      });
      streamController.add(event);
    });

    return streamController;
  }

}