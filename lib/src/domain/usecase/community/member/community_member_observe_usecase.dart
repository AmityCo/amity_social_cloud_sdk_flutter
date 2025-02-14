import 'dart:async';

import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/utils/amity_nonce.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/domain/repo/paging_id_repo.dart';

class CommunityMemberObserveUsecase extends ObserverUseCase<
    List<AmityCommunityMember>, GetCommunityMembersRequest> {
  final CommunityMemberRepo repo;
  final UserRepo userRepo;
  final CommunityMemberComposerUsecase usecase;
  final PagingIdRepo pagingRepo;

  CommunityMemberObserveUsecase(
      {required this.repo, required this.userRepo,  required this.usecase, required this.pagingRepo});

  @override
  StreamController<List<AmityCommunityMember>> listen(
      RequestBuilder<GetCommunityMembersRequest> request) {
    final hash = request().getHashCode();
    final nonce = request().getNonce().value;
    final streamController = StreamController<List<AmityCommunityMember>>();

    _onChanges(streamController, request);

    repo.listenCommunityMembers(request).listen((event) async {
      _onChanges(streamController, request);
    });
    pagingRepo.listenPagingIdEntities(nonce, hash).listen((event) async {
      _onChanges(streamController, request);
    });
    userRepo.listenUserEntities().listen((event) async {
      _onChanges(streamController, request);
    });

    return streamController;
  }

  void _onChanges(
    StreamController streamController,
    RequestBuilder<GetCommunityMembersRequest> request,
  ) {
    final hash = request().getHashCode();
    final nonce = request().getNonce().value;
    if (streamController.isClosed) {
      return;
    }
    final communityMemberEntities = repo.getComunityMemberEntities(request);
    
    final pagingIds = pagingRepo.getPagingIdEntities(nonce, hash);
    if (communityMemberEntities.isEmpty || pagingIds.isEmpty) {
      streamController.add(<AmityCommunityMember>[]);
    } else {
      final communityMemberIds = pagingIds.map((e) => e.id).toList();
      final communityMembers = communityMemberEntities
          .where((member) => communityMemberIds
              .contains(member.id))
          .map((e) => e.convertToAmityCommunityMember())
          .toList();

      Stream.fromIterable(communityMembers).forEach((element) async {
        element = await usecase.get(element);
      });

      if (!streamController.isClosed) {
        streamController.add(communityMembers);
      }
    }
  }
}
