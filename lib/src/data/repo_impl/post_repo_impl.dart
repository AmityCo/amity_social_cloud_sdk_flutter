import 'dart:async';
import 'dart:math';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/mapper/post_model_mapper.dart';
import 'package:amity_sdk/src/core/utils/amity_nonce.dart';
import 'package:amity_sdk/src/core/utils/model_mapper.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/domain/repo/paging_id_repo.dart';
import 'package:collection/collection.dart';

/// Post Repo
class PostRepoImpl extends PostRepo {
  /// Public post API interface
  final PublicPostApiInterface publicPostApiInterface;

  /// Common Db Adapter
  final DbAdapterRepo dbAdapterRepo;

  // Paging Id Repository
  final PagingIdRepo pagingIdRepo;

  /// Init Post Repo Impl
  PostRepoImpl({
    required this.publicPostApiInterface,
    required this.dbAdapterRepo,
    required this.pagingIdRepo,
  });

  @override
  Future<AmityPost> getPostById(String postId) async {
    //0. Get the data from local DB , change it to Amity Post and Emit it(converter extension)
    //1. Get the data from remote data source - PostEntity
    //2. Change the remote data source data PostEntity to PostHiveEntiry(converter extension)
    //3. Save the PostHiveEntity to local db(hive client)
    //4. Change this PostHiveentity to AmityPost and emit it again

    //Get the data from remote source and return it
    final data = await publicPostApiInterface.getPostById(postId);

    final amitPosts = await data.saveToDb<AmityPost>(dbAdapterRepo);

    return amitPosts[0];
  }

  @override
  Future<AmityPost> createPost(CreatePostRequest request) async {
    final data = await publicPostApiInterface.createPost(request);
    final amitPosts = await data.saveToDb<AmityPost>(dbAdapterRepo);
    return amitPosts[0];
  }

  @override
  Future<AmityPost> getPostByIdFromDb(String id) async {
    return dbAdapterRepo.postDbAdapter.getPostEntity(id)!.convertToAmityPost();
  }

  @override
  Future<bool> deletePostById(String postId) async {
    final data = await publicPostApiInterface.deletePostById(postId);

    ///Get the post from DB and update the delete flag to true
    final amityPostDb = dbAdapterRepo.postDbAdapter.getPostEntity(postId)!;
    amityPostDb.isDeleted = true;
    dbAdapterRepo.postDbAdapter.savePostEntity(amityPostDb);

    return data;
  }

  @override
  Future<bool> flagPost(String postId) async {
    final data = await publicPostApiInterface.flagPost(postId);
    await data.saveToDb<AmityPost>(dbAdapterRepo);

    // Update the isFlaggedByMe
    final post = dbAdapterRepo.postDbAdapter.getPostEntity(postId)!;
    post.flaggedByMe = true;
    post.save();

    return true;
  }

  @override
  Future<bool> isPostFlagByMe(String postId) async {
    final data = await publicPostApiInterface.isPostFlagByMe(postId);
    return data;
  }

  @override
  Future<bool> unflagPost(String postId) async {
    final data = await publicPostApiInterface.unflagPost(postId);
    await data.saveToDb<AmityPost>(dbAdapterRepo);

    // Update the isFlaggedByMe
    final post = dbAdapterRepo.postDbAdapter.getPostEntity(postId)!;
    post.flaggedByMe = false;
    post.save();

    return true;
  }

  @override
  Future<AmityPost> updatePostById(UpdatePostRequest request) async {
    final data = await publicPostApiInterface.updatePostById(request);
    final amitPosts = await data.saveToDb<AmityPost>(dbAdapterRepo);
    return amitPosts[0];
  }

  @override
  Future<PageListData<List<AmityPost>, String>> queryPost(
      GetPostRequest request) async {
    // if (request.options?.token == null) {
    //   await dbAdapterRepo.postDbAdapter
    //       .deletePostEntitiesByTargetId(request.targetId);
    // }
    final data = await publicPostApiInterface.queryPost(request);
    final amitPosts = await data.saveToDb<AmityPost>(dbAdapterRepo);
    return PageListData(amitPosts, data.paging!.next ?? '');
  }

  @override
  Stream<AmityPost> getPostByIdStream(String postId) {
    final controller = StreamController<AmityPost>();
    //1. Get Amity Post from local db
    getPostByIdFromDb(postId).then((value) {
      controller.add(value);
    }).onError((error, stackTrace) {});

    // 2. Make the API request and send the updated data back
    getPostById(postId).then((value) {
      controller.add(value);
    });

    //3. Listen any chagnes in the Amity Post Db and send the update back
    dbAdapterRepo.postDbAdapter.listenPostEntity(postId).listen((event) {
      controller.add(event.convertToAmityPost());
    });

    //1. Amity Post
    //2. Comment
    //3. User
    //4. File

    return controller.stream;
  }

  @override
  Future<bool> approvePost(String postId) async {
    final data = await publicPostApiInterface.approvePost(postId);
    return data;
  }

  @override
  Future<bool> declinePost(String postId) async {
    final data = await publicPostApiInterface.declinePost(postId);
    return data;
  }

  @override
  bool hasLocalPost(String postId) {
    return dbAdapterRepo.postDbAdapter.getPostEntity(postId) != null;
  }

  @override
  Future<AmityPost?> fetchAndSave(String objectId) async {
    var post = await getPostById(objectId);
    if (post != null) {
      return post;
    } else {
      await deletePostById(objectId);
      return Future.value(null);
    }
  }

  @override
  ModelMapper<PostHiveEntity, AmityPost> mapper() {
    return PostModelMapper();
  }

  @override
  StreamController<PostHiveEntity> observeFromCache(String objectId) {
    final streamController = StreamController<PostHiveEntity>();
    dbAdapterRepo.postDbAdapter.listenPostEntity(objectId).listen((event) {
      streamController.add(event);
    });
    return streamController;
  }

  @override
  Future<PostHiveEntity?> queryFromCache(String objectId) async {
    return dbAdapterRepo.postDbAdapter.getPostEntity(objectId);
  }

  @override
  Future<PageListData<List<AmityPost>, String>> queryPostList(
      GetPostRequest request) async {
    final nonce = request.getNonce();
    final hash = request.getHashCode();
    final pagingIdDbAdapter = dbAdapterRepo.pagingIdDbAdapter;
    int nextIndex = 0;
    final isFirstPage =
        request.options?.token == null && (request.options?.limit ?? 0) > 0;
    //TODO: request.options.token is gone after call data.saveToDb, might cause further issue in the future
    final data = await publicPostApiInterface.queryPost(request);
    await data.saveToDb(dbAdapterRepo);
    if (isFirstPage) {
      await pagingIdDbAdapter.deletePagingIdByHash(nonce.value, hash);
    } else {
      nextIndex = (pagingIdRepo
              .getPagingIdEntities(nonce.value, hash)
              .map((e) => (e.position ?? 0))
              .toList()
              .reduce(max)) +
          1;
    }
    data.posts.forEachIndexed((index, element) async {
      final pagingId = PagingIdHiveEntity(
        id: element.postId,
        hash: hash,
        nonce: nonce.value,
        position: nextIndex + index,
      );
      await pagingIdDbAdapter.savePagingIdEntity(pagingId);
    });

    return PageListData([], data.paging?.next ?? '');
  }

  @override
  Stream<List<AmityPost>> listenPosts(RequestBuilder<GetPostRequest> request) {
    final entities = dbAdapterRepo.postDbAdapter.listenPostEntities(request);
    return entities
        .map((event) => event.map((e) => e.convertToAmityPost()).toList());
  }

  @override
  Stream<List<PostHiveEntity>> listenAllPostEntities() {
    return dbAdapterRepo.postDbAdapter.listenAllPostEntities();
  }

  @override
  List<PostHiveEntity> getPostEntities(RequestBuilder<GetPostRequest> request) {
    return dbAdapterRepo.postDbAdapter.getPostEntities(request);
  }
}
