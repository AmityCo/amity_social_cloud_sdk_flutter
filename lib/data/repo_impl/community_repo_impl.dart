import 'dart:async';

import 'package:amity_sdk/core/model/api_request/create_community_request.dart';
import 'package:amity_sdk/domain/model/amity_community.dart';
import 'package:amity_sdk/domain/repo/community_repo.dart';
import 'package:amity_sdk/data/data.dart';

class CommunityRepoImpl extends CommunityRepo {
  final CommunityApiInterface communityApiInterface;
  final CommunityDbAdapter communityDbAdapter;
  final CommentDbAdapter commentDbAdapter;
  final UserDbAdapter userDbAdapter;
  final FileDbAdapter fileDbAdapter;

  //TODO: missing category, communityUser, feed
  CommunityRepoImpl({
    required this.communityApiInterface,
    required this.communityDbAdapter,
    required this.commentDbAdapter,
    required this.userDbAdapter,
    required this.fileDbAdapter,
  });

  @override
  Future<AmityCommunity> createCommunity(CreateCommunityRequest request) async {
    //TODO compose actual data
    final data = await communityApiInterface.createCommunity(request);
    return AmityCommunity();
  }

  @override
  Future<AmityCommunity> getCommunityById(String communityId) {
    // TODO: wait until the Stream API is done
    throw UnimplementedError();
  }
}
