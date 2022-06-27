import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class CommunityCategoryRepoImpl extends CommunityCategoryRepo {
  final CommunityCategoryApiInterface communityCategoryApiInterface;

  final CommunityDbAdapter communityDbAdapter;
  final CommentDbAdapter commentDbAdapter;
  final UserDbAdapter userDbAdapter;
  final FileDbAdapter fileDbAdapter;
  final CommunityCategoryDbAdapter communityCategoryDbAdapter;
  final CommunityFeedDbAdapter communityFeedDbAdapter;

  CommunityCategoryRepoImpl(
      {required this.communityDbAdapter,
      required this.commentDbAdapter,
      required this.userDbAdapter,
      required this.fileDbAdapter,
      required this.communityCategoryDbAdapter,
      required this.communityFeedDbAdapter,
      required this.communityCategoryApiInterface});
  @override
  Future<PageListData<List<AmityCommunityCategory>, String>>
      getCommunityCategoryQuery(GetCommunityCategoryRequest request) async {
    final data =
        await communityCategoryApiInterface.communityCategoryQuery(request);
    final amityCommunityCategory = await saveCommunity(data);
    return PageListData(amityCommunityCategory, data.paging?.next ?? '');
  }

  Future<List<AmityCommunityCategory>> saveCommunity(
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

    return communityCategoryHiveEnties
        .map((e) => e.convertToAmityCommunityCategory())
        .toList();
  }
}
