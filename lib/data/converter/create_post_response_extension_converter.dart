import 'package:amity_sdk/data/data.dart';
import 'package:amity_sdk/data/data_source/local/db_adapter_repo.dart';

extension CreatePostResponseExtension on CreatePostResponse {
  FeedPagingHiveEntity convertToFeedHiveEntity() => FeedPagingHiveEntity()
    ..id = '$hashCode'
    ..postIds = posts.map((e) => e.postId).toList()
    ..nextToken = paging?.next;

  Future saveToDb(DbAdapterRepo dbRepo) async {
    //Convert to File Hive Entity
    //we have save the file first, since every object depends on file
    List<FileHiveEntity> fileHiveEntities =
        files.map((e) => e.convertToFileHiveEntity()).toList();

    //Convert to Community Hive Entity
    List<CommunityHiveEntity> communityHiveEntities =
        communities.map((e) => e.convertToCommunityHiveEntity()).toList();

    //Convert to User Hive Entity
    List<UserHiveEntity> userHiveEntities =
        users.map((e) => e.convertToUserHiveEntity()).toList();

    //Convert to Comment Hive Entity
    List<CommentHiveEntity> commentHiveEntities =
        comments.map((e) => e.convertToCommentHiveEntity()).toList();

    //Convert Child Post to Post Hive Entity
    List<PostHiveEntity> postChildHiveEntities =
        postChildren.map((e) => e.convertToPostHiveEntity()).toList();

    //Conver Post to Post Hive Entity
    List<PostHiveEntity> postHiveEntities =
        posts.map((e) => e.convertToPostHiveEntity()).toList();

    //Save the File Entity
    for (var e in fileHiveEntities) {
      await dbRepo.fileDbAdapter.saveFileEntity(e);
    }

    //Save the Community Entity
    for (var e in communityHiveEntities) {
      await dbRepo.communityDbAdapter.saveCommunityEntity(e);
    }

    //Save Child Post Entity
    for (var e in postChildHiveEntities) {
      await dbRepo.postDbAdapter.savePostEntity(e);
    }

    //Save the User Entity
    for (var e in userHiveEntities) {
      await dbRepo.userDbAdapter.saveUserEntity(e);
    }

    //Save the Comment Entity
    for (var e in commentHiveEntities) {
      await dbRepo.commentDbAdapter.saveCommentEntity(e);
    }

    //Save Post Entity
    for (var e in postHiveEntities) {
      await dbRepo.postDbAdapter.savePostEntity(e);
    }
  }
}
