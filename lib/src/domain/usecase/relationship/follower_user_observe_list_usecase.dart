import 'dart:async';

import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/utils/amity_nonce.dart';
import 'package:amity_sdk/src/data/converter/follow_hive_entity_extension_converter.dart';
import 'package:amity_sdk/src/domain/composer_usecase/follower_user_composer_usecase.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/domain/repo/paging_id_repo.dart';

class FollowerUserObserveListUseCase
    extends ObserverUseCase<List<AmityFollowRelationship>, FollowRequest> {
  final FollowRepo followRepo;
  final PagingIdRepo pagingIdRepo;
  final FollowerUserComposerUsecase followerUserComposerUsecase;
  final UserRepo userRepo;

  FollowerUserObserveListUseCase(
      {required this.followRepo,
      required this.pagingIdRepo,
      required this.followerUserComposerUsecase,
      required this.userRepo});

  @override
  StreamController<List<AmityFollowRelationship>> listen(
      RequestBuilder<FollowRequest> request) {
    final hash = request().getHashCode();
    final nonce = request().getFollowerNonce().value;
    final streamController = StreamController<List<AmityFollowRelationship>>();
    followRepo.listenFollowers(request).listen((event) async {
      _onChanges(streamController, request);
    });
    pagingIdRepo.listenPagingIdEntities(nonce, hash).listen((event) async {
      _onChanges(streamController, request);
    });
    userRepo.listenUserEntities().listen((event) async {
      _onChanges(streamController, request);
    });

    return streamController;
  }

  void _onChanges(
    StreamController streamController,
    RequestBuilder<FollowRequest> request,
  ) async {
    final hash = request().getHashCode();
    final nonce = request().getFollowerNonce().value;
    if (streamController.isClosed) {
      return;
    }
    final followEntities = followRepo.getFollowEntities(request);

    final pagingIds = pagingIdRepo.getPagingIdEntities(nonce, hash);
    pagingIds.sort((a, b) => (a.position ?? 0).compareTo(b.position ?? 0));

    if (followEntities.isEmpty || pagingIds.isEmpty) {
      streamController.add(<AmityFollowRelationship>[]);
    } else {
      final uniqueIds = pagingIds.map((e) => e.id).toList();
      final follows = followEntities
          .where((follow) => uniqueIds.contains(follow.id))
          .map((e) => e.convertToAmityFollowRelationship())
          .toList()
        ..sort((a, b) => (b.createdAt ?? DateTime.now())
            .compareTo(a.createdAt ?? DateTime.now()));
      await Stream.fromIterable(follows).forEach((element) async {
        element = await followerUserComposerUsecase.get(element);
      });

      if (!streamController.isClosed) {
        streamController.add(follows);
      }
    }
  }
}
