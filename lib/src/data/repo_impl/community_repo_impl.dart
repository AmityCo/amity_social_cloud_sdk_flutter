// ignore_for_file: unused_local_variable

import 'dart:async';

import 'package:amity_sdk/src/core/model/api_request/create_community_request.dart';
import 'package:amity_sdk/src/data/converter/community_category_response_extension_converter.dart';
import 'package:amity_sdk/src/data/converter/community_feed_response_extension_converter.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/data/data_source/local/db_adapter/community_category_db_adater.dart';
import 'package:amity_sdk/src/data/data_source/local/db_adapter/community_feed_db_adapter.dart';
import 'package:amity_sdk/src/data/data_source/local/hive_entity/community_category_hive_12.dart';
import 'package:amity_sdk/src/data/data_source/local/hive_entity/community_feed_hive_13.dart';
import 'package:amity_sdk/src/domain/model/community/amity_community.dart';
import 'package:amity_sdk/src/domain/repo/community_repo.dart';

class CommunityRepoImpl extends CommunityRepo {
  final CommunityApiInterface communityApiInterface;
  final CommunityDbAdapter communityDbAdapter;
  final CommentDbAdapter commentDbAdapter;
  final UserDbAdapter userDbAdapter;
  final FileDbAdapter fileDbAdapter;
  final CommunityCategoryDbAdapter communityCategoryDbAdapter;
  final CommunityFeedDbAdapter communityFeedDbAdapter;

  //TODO: missing  communityUser
  CommunityRepoImpl({
    required this.communityApiInterface,
    required this.communityDbAdapter,
    required this.commentDbAdapter,
    required this.userDbAdapter,
    required this.fileDbAdapter,
    required this.communityCategoryDbAdapter,
    required this.communityFeedDbAdapter,
  });

  @override
  Future<AmityCommunity> createCommunity(CreateCommunityRequest request) async {
    final data = await communityApiInterface.createCommunity(request);
    return AmityCommunity();
  }

  @override
  Future<AmityCommunity> getCommunityById(String communityId) async {
    return communityDbAdapter
        .getCommunityEntity(communityId)
        .convertToAmityCommunity();
  }

  @override
  Future deleteCommunity(String communityId) async {
    final data = await communityApiInterface.deleteCommunity(communityId);

    ///Get the post from DB and update the delete flag to true
    final amityCommunityDb = commentDbAdapter.getCommentEntity(communityId);
    amityCommunityDb
      ..isDeleted = true
      ..save();

    return data;
  }

  @override
  Future<AmityCommunity> getCommunity(String communityId) async {
    final data = await communityApiInterface.getCommunity(communityId);
    final amityCommunity = await saveCommunity(data);
    return amityCommunity.first;
  }

  @override
  Future<AmityCommunity> updateCommunity(CreateCommunityRequest request) async {
    final data = await communityApiInterface.updateCommunity(request);
    final amityCommunity = await saveCommunity(data);
    return amityCommunity.first;
  }

  Future<List<AmityCommunity>> saveCommunity(
      CreateCommunityResponse data) async {
    //Convert to File Hive Entity
    //we have save the file first, since every object depends on file
    List<FileHiveEntity> fileHiveEntities =
        data.files.map((e) => e.convertToFileHiveEntity()).toList();

    //Convert to User Hive Entity
    List<UserHiveEntity> userHiveEntities =
        data.users.map((e) => e.convertToUserHiveEntity()).toList();

    //Conver to community hive member

    //Conver to category hive entity
    List<CommunityCategoryHiveEntity> communityCategoryHiveEnties = data
        .categories
        .map((e) => e.convertToCommunityCategoryHiveEntity())
        .toList();

    //Conver to Feed hive entity
    List<CommunityFeedHiveEntity> communityFeedHiveEnties =
        data.feeds.map((e) => e.convertToCommunityFeedHiveEntity()).toList();

    //Conver to Feed hive entity
    List<CommunityHiveEntity> communityHiveEnties =
        data.communities.map((e) => e.convertToCommunityHiveEntity()).toList();

    //Save the File Entity
    for (var e in fileHiveEntities) {
      await fileDbAdapter.saveFileEntity(e);
    }

    //Save the User Entity
    for (var e in userHiveEntities) {
      await userDbAdapter.saveUserEntity(e);
    }

    //Save the Community Category Entity
    for (var e in communityCategoryHiveEnties) {
      await communityCategoryDbAdapter.saveCommunityCategoryEntity(e);
    }

    //Save the Community Feed Entity
    for (var e in communityFeedHiveEnties) {
      await communityFeedDbAdapter.saveCommunityFeedEntity(e);
    }

    //Save the Community  Entity
    for (var e in communityHiveEnties) {
      await communityDbAdapter.saveCommunityEntity(e);
    }

    return communityHiveEnties.map((e) => e.convertToAmityCommunity()).toList();
  }
}
