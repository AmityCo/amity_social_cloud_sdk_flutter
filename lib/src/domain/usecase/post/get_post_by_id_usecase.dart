import 'dart:async';

import 'package:amity_sdk/src/core/usercase/usecase.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class GetPostByIdUseCase extends UseCase<AmityPost, String> {
  final PostRepo postRepo;
  final PostComposerUsecase postComposerUsecase;
  GetPostByIdUseCase(
      {required this.postRepo, required this.postComposerUsecase});

  @override
  Future<AmityPost> get(String params) async {
    //1. Get the public model (AmityPost) from data layer
    //2. Use the composer usecase to compose the public model (fill the detail)

    final amityPost = await postRepo.getPostById(params);
    final amityComposedPost = await postComposerUsecase.get(amityPost);
    return amityComposedPost;
  }

  /// Listen Post By Id
  StreamController<AmityPost> listen(String params) {
    //1. Listen to Amity post stream
    //2. compose the Amity post
    StreamController<AmityPost> controller = StreamController<AmityPost>();

    postRepo.getPostByIdStream(params).listen((event) async {
      final amityComposedPost = await postComposerUsecase.get(event);
      controller.add(amityComposedPost);
    });

    return controller;
  }
}
