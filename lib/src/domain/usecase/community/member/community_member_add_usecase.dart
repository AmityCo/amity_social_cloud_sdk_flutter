import 'dart:async';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class CommunityMemberAddUsecase extends UseCase<dynamic, UpdateCommunityMembersRequest> {
  final CommunityMemberRepo communityMemberRepo;
  final CommunityMemberComposerUsecase communityMemberComposerUsecase;

  CommunityMemberAddUsecase({required this.communityMemberRepo, required this.communityMemberComposerUsecase});

  @override
  Future<dynamic> get(UpdateCommunityMembersRequest params) async {
    return communityMemberRepo.addMember(params);
  }
}
