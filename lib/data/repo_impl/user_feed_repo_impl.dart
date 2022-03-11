import 'package:amity_sdk/core/model/api_request/get_user_feed_request.dart';
import 'package:amity_sdk/core/utils/tuple.dart';
import 'package:amity_sdk/data/data.dart';
import 'package:amity_sdk/data/data_source/remote/api_interface/user_feed_api_interface.dart';
import 'package:amity_sdk/domain/model/amity_post.dart';
import 'package:amity_sdk/domain/repo/user_feed_repo.dart';

class UserFeedRepoImpl extends UserFeedRepo {
  final UserFeedApiInterface _userFeedApiInterface;
  final PostDbAdapter postDbAdapter;
  final CommentDbAdapter commentDbAdapter;
  final UserDbAdapter userDbAdapter;
  final FileDbAdapter fileDbAdapter;

  UserFeedRepoImpl(this._userFeedApiInterface, this.postDbAdapter,
      this.commentDbAdapter, this.userDbAdapter, this.fileDbAdapter);

  @override
  Future<Tuple2<List<AmityPost>, String>> getUserFeed(
      GetUserFeedRequest request) async {
    final data = await _userFeedApiInterface.getUserFeed(request);

    final amitPosts = await _saveDataToDb(data);

    return Tuple2(amitPosts, data.paging!.next!);
  }

  Future<List<AmityPost>> _saveDataToDb(CreatePostResponse data) async {
    //Convert to File Hive Entity
    //we have save the file first, since every object depends on file
    List<FileHiveEntity> fileHiveEntities =
        data.files.map((e) => e.convertToFileHiveEntity()).toList();

    //Convert to User Hive Entity
    List<UserHiveEntity> userHiveEntities =
        data.users.map((e) => e.convertToUserHiveEntity()).toList();

    //Convert to Comment Hive Entity
    List<CommentHiveEntity> commentHiveEntities =
        data.comments.map((e) => e.convertToCommentHiveEntity()).toList();

    //Convert to Post Hive Entity
    List<PostHiveEntity> postChildHiveEntities =
        data.postChildren.map((e) => e.convertToPostHiveEntity()).toList();

    List<PostHiveEntity> postHiveEntities =
        data.posts.map((e) => e.convertToPostHiveEntity()).toList();

    //Save the File Entity
    for (var e in fileHiveEntities) {
      await fileDbAdapter.saveFileEntity(e);
    }

    //Save Child Post Entity
    for (var e in postChildHiveEntities) {
      await postDbAdapter.savePostEntity(e);
    }

    //Save the User Entity
    for (var e in userHiveEntities) {
      await userDbAdapter.saveUserEntity(e);
    }

    //Save the Comment Entity
    for (var e in commentHiveEntities) {
      await commentDbAdapter.saveCommentEntity(e);
    }

    //Save Post Entity
    for (var e in postHiveEntities) {
      await postDbAdapter.savePostEntity(e);
    }

    return postHiveEntities.map((e) => e.convertToAmityPost()).toList();
  }
}
