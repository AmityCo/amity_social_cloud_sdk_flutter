import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/data/converter/pin_response_extension_converter.dart';
import 'package:amity_sdk/src/data/converter/stream/stream_response_extension_converter.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/data/data_source/local/hive_entity/stream_hive_entity_22.dart';
import 'package:amity_sdk/src/data/response/pinned_post_response.dart';
import 'package:collection/collection.dart';

extension PinnedPostQueryResponseExtension on PinnedPostQueryResponse {
  Future saveToDb<T>(DbAdapterRepo dbRepo) async {
    //we have save the file first, since every object depends on file
    List<FileHiveEntity> fileHiveEntities =
        files.map((e) => e.convertToFileHiveEntity()).toList();

    //Conver the community category to CommunityCategoryHiveEntity
    List<CommunityCategoryHiveEntity> communityCategoryHiveEntities = categories
        .map((e) => e.convertToCommunityCategoryHiveEntity())
        .toList();

    //Convert to Community Hive Entity
    List<CommunityHiveEntity> communityHiveEntities =
        communities.map((e) => e.convertToCommunityHiveEntity()).toList();

    List<CommunityMemberHiveEntity> communityUsersHiveEntities = communityUsers
        .map((e) => e.convertToCommnityMemberHiveEntity())
        .toList();

    //Convert to User Hive Entity
    List<UserHiveEntity> userHiveEntities =
        users.map((e) => e.convertToUserHiveEntity()).toList();

    //Convert to Comment Hive Entity
    List<CommentHiveEntity> commentHiveEntities =
        comments.map((e) => e.convertToCommentHiveEntity()).toList();

    //Convert Child Post to Post Hive Entity
    List<PostHiveEntity> postChildHiveEntities = postChildren.map((e) {
      var postEntity = e.convertToPostHiveEntity();
      postEntity.feedType = getFeedTypeFromId(e.feedId, feeds);
      return postEntity;
    }).toList();

    //Convert Child Post to Post Hive Entity
    List<StreamHiveEntity> streamHiveEntities =
        videoStreamings.map((e) => e.convertToStreamHiveEntity()).toList();

    //Conver Post to Post Hive Entity
    List<PostHiveEntity> postHiveEntities = posts.map((e) {
      var postEntity = e.convertToPostHiveEntity();
      postEntity.feedType = getFeedTypeFromId(e.feedId, feeds);
      return postEntity;
    }).toList();

    //Conver Post to Poll Hive Entity
    List<PollHiveEntity> pollHiveEntities =
        polls.map((e) => e.convertToPollHiveEntity()).toList();

    final target = getTartget();
    List<PinHiveEntity> pinHiveEntities = [];
    if (target != null) {
      pinHiveEntities = pins.map((e) => e.convertToPinHiveEntity(target)).toList();
    }

    //Save the File Entity
    for (var e in fileHiveEntities) {
      await dbRepo.fileDbAdapter.saveFileEntity(e);
    }

    //Save the community Category
    for (var e in communityCategoryHiveEntities) {
      await dbRepo.communityCategoryDbAdapter.saveCommunityCategoryEntity(e);
    }

    //Save the User Entity
    for (var e in userHiveEntities) {
      await dbRepo.userDbAdapter.saveUserEntity(e);
    }

    //Save the Comment Entity
    for (var e in commentHiveEntities) {
      await dbRepo.commentDbAdapter.saveCommentEntity(e);
    }

    //Save the Stream Entity
    for (var e in streamHiveEntities) {
      await dbRepo.streamDbAdapter.saveStreamEntity(e);
    }

    //Save the Community Entity
    for (var e in communityHiveEntities) {
      await dbRepo.communityDbAdapter.saveCommunityEntity(e);
    }

    for (var e in communityUsersHiveEntities) {
      final UserHiveEntity? user = userHiveEntities
          .firstWhereOrNull((element) => element.userId == e.userId);
      await dbRepo.communityMemberDbAdapter.saveCommunityMemberEntity(e, user);
    }

    //Save Child Post Entity
    for (var e in postChildHiveEntities) {
      await dbRepo.postDbAdapter.savePostEntity(e);
    }

    //Save Poll Entity
    for (var e in pollHiveEntities) {
      await dbRepo.pollDbAdapter.savePollEntity(e);
    }

    //Save Post Entity
    for (var e in postHiveEntities) {
      await dbRepo.postDbAdapter.savePostEntity(e);
    }

    //Save Pin Entity
    for (var e in pinHiveEntities) {
      await dbRepo.pinDbAdapter.savePinEntity(e);
    }

    // FIXME: right logic for type checking
    if (T.toString() == 'AmityPost') {
      return postHiveEntities.map((e) => e.convertToAmityPost()).toList();
    }

    // FIXME: right logic for type checking
    if (T.toString() == 'AmityPoll') {
      return pollHiveEntities.map((e) => e.convertToAmityPoll()).toList();
    }
  }

  String getFeedTypeFromId(String? feedId, List<CommunityFeedResponse> feeds) {
    if (feedId == null) {
      return AmityFeedType.PUBLISHED.value;
    }
    var feed = feeds.firstWhere((element) => element.feedId == feedId);
    if (feed != null) {
      return feed.feedType;
    }
    return AmityFeedType.PUBLISHED.value;
  }
}
