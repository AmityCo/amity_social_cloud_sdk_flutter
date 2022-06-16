import 'dart:async';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class CommunityCategoryQueryUsecase extends UseCase<
    Tuple2<List<AmityCommunityCategory>, String>, GetCommunityCategoryRequest> {
  final CommunityCategoryRepo communityCategoryRepo;
  final CommunityCategoryComposerUsecase communityCategoryComposerUsecase;

  CommunityCategoryQueryUsecase(
      {required this.communityCategoryRepo,
      required this.communityCategoryComposerUsecase});

  @override
  Future<Tuple2<List<AmityCommunityCategory>, String>> get(
      GetCommunityCategoryRequest params) async {
    final amityCommunityCategoryTuple =
        await communityCategoryRepo.getCommunityCategoryQuery(params);
    final amityComposedCommunityCategory =
        await Stream.fromIterable(amityCommunityCategoryTuple.item1)
            .asyncMap((event) => communityCategoryComposerUsecase.get(event))
            .toList();
    return amityCommunityCategoryTuple
        .withItem1(amityComposedCommunityCategory);
  }

  @override
  Stream<Tuple2<List<AmityCommunityCategory>, String>> listen(
      GetCommunityCategoryRequest params) {
    // TODO: implement listen
    throw UnimplementedError();
  }
}
