import 'dart:async';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class CommunityCategoryQueryUsecase extends UseCase<
    PageListData<List<AmityCommunityCategory>, String>,
    GetCommunityCategoryRequest> {
  final CommunityCategoryRepo communityCategoryRepo;
  final CommunityCategoryComposerUsecase communityCategoryComposerUsecase;

  CommunityCategoryQueryUsecase(
      {required this.communityCategoryRepo,
      required this.communityCategoryComposerUsecase});

  @override
  Future<PageListData<List<AmityCommunityCategory>, String>> get(
      GetCommunityCategoryRequest params) async {
    final amityCommunityCategoryTuple =
        await communityCategoryRepo.getCommunityCategoryQuery(params);
    final amityComposedCommunityCategory =
        await Stream.fromIterable(amityCommunityCategoryTuple.data)
            .asyncMap((event) => communityCategoryComposerUsecase.get(event))
            .toList();
    return amityCommunityCategoryTuple
        .withItem1(amityComposedCommunityCategory);
  }
}
