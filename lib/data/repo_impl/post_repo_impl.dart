import 'dart:async';

import 'package:amity_sdk/data/data.dart';
import 'package:amity_sdk/domain/model/amity_post.dart';
import 'package:amity_sdk/domain/repo/post_repo.dart';

class PostRepoImpl extends PostRepo {
  final PublicPostApiInterface publicPostApiInterface;
  final PostDbAdapter postDbAdapter;
  PostRepoImpl(
      {required this.publicPostApiInterface, required this.postDbAdapter});

  @override
  Future<AmityPost> getPostById(String postId) async {
    //0. Get the data from local DB , change it to Amity Post and Emit it(converter extension)
    //1. Get the data from remote data source - PostEntity
    //2. Change the remote data source data PostEntity to PostHiveEntiry(converter extension)
    //3. Save the PostHiveEntity to local db(hive client)
    //4. Change this PostHiveentity to AmityPost and emit it again

    //Get the data from remote source and return it
    final data = await publicPostApiInterface.getPostById(postId);
    return Future.value(data.data.posts[0].convertToAmityPost());
  }
}
