import 'dart:async';

import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class PostObserveUseCase extends UseCase<List<AmityPost>, GetPostRequest> {
  final PostRepo postRepo;
  final PostComposerUsecase postComposerUsecase;

  PostObserveUseCase(
      {required this.postRepo, required this.postComposerUsecase});

  @override
  Future<List<AmityPost>> get(params) {
    throw UnimplementedError();
  }

  StreamController<List<AmityPost>> listen(
      RequestBuilder<GetPostRequest> request) {
    final streamController = StreamController<List<AmityPost>>();
    postRepo.listenPosts(request).listen((event) async {
      await Stream.fromIterable(event).forEach((element) async {
        element = await postComposerUsecase.get(element);
      });
      streamController.add(event);
    });
    return streamController;
  }
}
